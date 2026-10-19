//
//  TabBar.swift
//  TossTabBar
//
//  Created by Huigyun Jeong on 10/9/26.
//

import SwiftUI

struct TabBar<SelectionValue, Content>: View
where SelectionValue: Hashable, Content: View {
    @Binding private var selection: SelectionValue
    private let content: Content

    private let spacing: CGFloat = -8

    init(
        selection: Binding<SelectionValue>,
        @ContentBuilder content: () -> Content
    ) {
        self._selection = selection
        self.content = content()
    }

    var body: some View {
        HStack(spacing: spacing) {
            ForEach(subviews: content) { subview in
                let tag = subview.containerValues.tag(for: SelectionValue.self)

                subview
                    .labelStyle(.tab)
                    .symbolVariant(selection == tag ? .fill : .none)
                    .padding(12)
                    .frame(maxWidth: 96)
            }
        }
        .tabBarBackground(
            selection: $selection,
            content: content,
            spacing: spacing
        )
        .animation(.snappy, value: selection)
        .glassEffect(.regular.interactive(), in: .capsule)
    }
}

private struct TabBarBackgroundModifier<S, C>: ViewModifier
where S: Hashable, C: View {
    @Binding var selection: S
    var content: C
    let spacing: CGFloat

    @State private var viewWidth: CGFloat = 0
    @GestureState private var position: CGFloat? = nil

    func body(content: Content) -> some View {
        Group(subviews: self.content) { subviews in
            let tabs = subviews.compactMap { subview in
                subview.containerValues.tag(for: S.self)
            }

            let capsuleWidth: CGFloat = capsuleWidth(
                count: tabs.count,
                from: viewWidth,
                spacing: spacing,
            )

            content
                .onGeometryChange(for: CGFloat.self) { geometry in
                    return geometry.size.width
                } action: { newValue in
                    self.viewWidth = newValue
                }
                .contentShape(.capsule)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .updating($position) { value, state, _ in
                            state = value.location.x
                        }
                        .onEnded { value in
                            guard
                                let tab = item(
                                    in: tabs,
                                    from: value.location.x,
                                    viewWidth: viewWidth
                                )
                            else { return }

                            self.selection = tab
                        }
                )
                .background {
                    let position: CGFloat? =
                        position
                        ?? position(
                            for: selection,
                            in: tabs,
                            from: capsuleWidth,
                            spacing: spacing
                        )

                    if let position {
                        TabBarBackground(
                            capsuleWidth: capsuleWidth,
                            position: position
                        )
                        .animation(.snappy, value: position)
                    }
                }
        }
    }

    private func capsuleWidth(
        count: Int,
        from viewWidth: CGFloat,
        spacing: CGFloat
    ) -> CGFloat {
        return (viewWidth + -spacing * max(0, CGFloat(count - 1))) / CGFloat(count)
    }

    private func position<V>(
        for item: V,
        in items: [V],
        from capsuleWidth: CGFloat,
        spacing: CGFloat
    ) -> CGFloat? where V: Equatable {
        guard let index = items.firstIndex(of: item) else { return nil }

        return capsuleWidth * CGFloat(index) + spacing * max(0, CGFloat(index)) + capsuleWidth / 2
    }

    private func item<V>(
        in items: [V],
        from position: CGFloat,
        viewWidth: CGFloat
    ) -> V? {
        let count: Int = items.count
        let visibleCapsuleWidth: CGFloat = viewWidth / CGFloat(count)
        let index: Int = Int(position / visibleCapsuleWidth)

        guard items.indices.contains(index) else { return nil }

        return items[index]
    }
}

@Animatable
private struct TabBarBackground: View {
    var capsuleWidth: CGFloat
    var position: CGFloat

    var body: some View {
        Canvas { context, size in
            let capsule: some InsettableShape = Capsule().inset(by: 4)

            let capsuleX: CGFloat = position - capsuleWidth / 2
            let capsuleOrigin: CGPoint = .init(
                x: min(size.width - capsuleWidth, max(0, capsuleX)),
                y: 0
            )

            let capsuleSize: CGSize = .init(
                width: capsuleWidth,
                height: size.height
            )

            context
                .fill(
                    capsule.path(
                        in: .init(
                            origin: capsuleOrigin,
                            size: capsuleSize
                        )
                    ),
                    with: .style(.quinary)
                )
        }
    }
}

extension View {
    fileprivate func tabBarBackground<S, C>(
        selection: Binding<S>,
        content: C,
        spacing: CGFloat
    ) -> some View where S: Hashable, C: View {
        self
            .modifier(
                TabBarBackgroundModifier(
                    selection: selection,
                    content: content,
                    spacing: spacing
                )
            )
    }
}

private struct TabLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 2) {
            configuration.icon
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .frame(height: 28)

            configuration.title
                .font(.system(size: 10))
                .fontWeight(.semibold)
        }
    }
}

extension LabelStyle where Self == TabLabelStyle {
    fileprivate static var tab: Self { return .init() }
}

#Preview {
    @Previewable @State var selection: RootTab = .home

    TabBar(selection: $selection) {
        ForEach(RootTab.allCases) { tab in
            Label(tab.title, systemImage: tab.symbol)
                .tag(tab)
        }
    }
    .padding(21)
}
