//
//  ContentView.swift
//  TossTabBar
//
//  Created by Huigyun Jeong on 10/9/26.
//

import SwiftUI

struct ContentView: View {
    @State private var router: Router = .init()

    var body: some View {
        TabView(selection: $router.rootSelection) {
            Tab(value: .home) {
                HomeView()
                    .toolbarVisibility(.hidden, for: .tabBar)
            }

            Tab(value: .benefit) {
                BenefitView()
                    .toolbarVisibility(.hidden, for: .tabBar)
            }

            Tab(value: .shopping) {
                ShoppingView()
                    .toolbarVisibility(.hidden, for: .tabBar)
            }

            Tab(value: .invest) {
                InvestTabView(selection: $router.investSelection)
                    .toolbarVisibility(.hidden, for: .tabBar)
            }

            Tab(value: .all) {
                AllView()
                    .toolbarVisibility(.hidden, for: .tabBar)
            }
        }
        .safeAreaInset(edge: .bottom) {
            TossTabBar(router: router)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .bottom
                )
                .padding(21)
                .ignoresSafeArea(.container, edges: .bottom)
        }
    }
}

extension ContentView {
    struct HomeView: View {
        private let shape: some Shape = .rect(cornerRadius: 24)

        var body: some View {
            ScrollView {
                LazyVStack(spacing: 12) {
                    shape
                        .fill(.background.secondary)
                        .frame(height: 160)

                    shape
                        .fill(.background.secondary)
                        .frame(height: 64)

                    shape
                        .fill(.background.secondary)
                        .frame(height: 128)

                    shape
                        .fill(.background.secondary)
                        .frame(height: 320)
                }
                .frame(maxWidth: .infinity)
            }
            .contentMargins(16, for: .scrollContent)
            .background(.background.secondary)
            .safeAreaBar(edge: .top) {
                HStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Text("토스뱅크")
                            .font(.title3)
                            .bold()
                        Image(systemName: "chevron.right")
                            .font(.caption)
                    }

                    Spacer()

                    Group {
                        Image(systemName: "creditcard")
                        Image(systemName: "bell")
                    }
                    .font(.title3)
                }
                .foregroundStyle(.secondary)
                .safeAreaPadding(16)
            }
        }
    }

    struct BenefitView: View {
        private let shape: some Shape = .rect(cornerRadius: 24)

        var body: some View {
            ScrollView {
                LazyVStack(spacing: 12) {
                    shape
                        .fill(.background.secondary)
                        .frame(height: 160)

                    shape
                        .fill(.background.secondary)
                        .frame(height: 64)

                    shape
                        .fill(.background.secondary)
                        .frame(height: 128)

                    shape
                        .fill(.background.secondary)
                        .frame(height: 320)
                }
                .frame(maxWidth: .infinity)
            }
            .contentMargins(16, for: .scrollContent)
            .background(.background.secondary)
        }
    }

    struct ShoppingView: View {
        private let shape: some Shape = .rect(cornerRadius: 24)

        var body: some View {
            ScrollView {
                LazyVStack(spacing: 12) {
                    shape
                        .fill(.background.secondary)
                        .frame(height: 320)
                }
                .frame(maxWidth: .infinity)
            }
            .contentMargins(16, for: .scrollContent)
            .safeAreaBar(edge: .top) {
                VStack(spacing: 12) {
                    HStack(spacing: 16) {
                        HStack(spacing: 4) {
                            Image(systemName: "magnifyingglass")
                                .font(.caption)

                            Text("상품을 검색해보세요")
                                .foregroundStyle(.tertiary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(8)
                        .background(
                            .background.secondary,
                            in: .rect(cornerRadius: 8)
                        )

                        Group {
                            Image(systemName: "person")

                            Image(systemName: "cart")
                        }
                        .font(.title3)
                    }
                    .foregroundStyle(.secondary)

                    HStack {
                        Group {
                            Text("홈")
                            Text("뷰티")
                            Text("카테고리")
                            Text("선착순특가")
                        }
                        .padding(8)
                    }
                    .foregroundStyle(.secondary)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                }
                .safeAreaPadding([.top, .horizontal], 16)
            }
        }
    }

    struct AllView: View {
        private let shape: some Shape = .rect(cornerRadius: 24)

        var body: some View {
            ScrollView {
                LazyVStack(spacing: 12) {
                    HStack {
                        Group {
                            Label("토스뱅크", systemImage: "wonsign.building.classical")
                                .symbolVariant(.fill)

                            Label("미니앱", systemImage: "rectangle.grid.2x2")
                                .symbolVariant(.fill)

                            Label("게임", systemImage: "gamecontroller")
                                .symbolVariant(.fill)
                        }
                        .padding(12)
                        .background(.quinary, in: .capsule)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    shape
                        .fill(.background.secondary)
                        .frame(height: 160)

                    shape
                        .fill(.background.secondary)
                        .frame(height: 128)

                    shape
                        .fill(.background.secondary)
                        .frame(height: 320)
                }
                .frame(maxWidth: .infinity)
            }
            .contentMargins([.bottom, .horizontal], 16, for: .scrollContent)
            .background(.background.secondary)
            .safeAreaBar(edge: .top) {
                VStack {
                    HStack(spacing: 16) {
                        Text("김토스")
                            .bold()
                            .foregroundStyle(.primary)

                        Spacer()

                        Group {
                            Text("고객센터")

                            Text("설정")
                        }
                        .bold()
                        .foregroundStyle(.secondary)
                    }

                    HStack {
                        Image(systemName: "magnifyingglass")

                        Text("검색")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .foregroundStyle(.secondary)
                    .padding(12)
                    .background(
                        .background,
                        in: .rect(cornerRadius: 12)
                    )
                }
                .safeAreaPadding(16)
            }
        }
    }
}

#Preview {
    ContentView()
}
