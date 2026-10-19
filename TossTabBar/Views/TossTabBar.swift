//
//  TossTabBar.swift
//  TossTabBar
//
//  Created by Huigyun Jeong on 10/13/26.
//

import SwiftUI

struct TossTabBar: View {
    @Bindable var router: Router

    private let animation: Animation = .snappy

    var body: some View {
        GlassEffectContainer {
            HStack {
                if router.canGoBack {
                    Button {
                        router.goBack()
                    } label: {
                        Label("뒤로가기", systemImage: "chevron.backward")
                            .labelStyle(.iconOnly)
                            .frame(width: 36, height: 36)
                    }
                    .buttonStyle(.glass)
                    .controlSize(.extraLarge)
                    .buttonBorderShape(.circle)
                }

                TabBar(selection: $router.tabBarSelection) {
                    ForEach(
                        router.visibleTabs.enumerated(),
                        id: \.element.id
                    ) { index, tab in
                        Label(tab.title, systemImage: tab.symbol)
                            .transition(
                                .tossTabItem
                                    .animation(
                                        animation
                                            .delay(0.25 + 0.05 * TimeInterval(index))
                                    )
                            )
                            .tag(tab)
                    }
                }
            }
        }
        .animation(animation, value: router.currentSelection)
    }
}

private struct TossTabItemTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .scaleEffect(scale(phase: phase))
    }

    private func scale(phase: TransitionPhase) -> CGFloat {
        switch phase {
        case .willAppear:
            return 0.0
        case .identity:
            return 1.0
        case .didDisappear:
            return 1.0
        }
    }
}

extension Transition where Self == TossTabItemTransition {
    fileprivate static var tossTabItem: Self { .init() }
}

#Preview {
    @Previewable @State var router: Router = .init()

    TossTabBar(router: router)
        .padding()
}
