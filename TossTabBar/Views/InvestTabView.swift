//
//  InvestTabView.swift
//  TossTabBar
//
//  Created by Huigyun Jeong on 10/13/26.
//

import SwiftUI

struct InvestTabView: View {
    @Binding var selection: InvestTab

    var body: some View {
        TabView(selection: $selection) {
            Tab(value: .home) {
                HomeView()
                    .toolbarVisibility(.hidden, for: .tabBar)
            }

            Tab(value: .favorite) {
                FavoriteView()
                    .toolbarVisibility(.hidden, for: .tabBar)
            }

            Tab(value: .discover) {
                DiscoverView()
                    .toolbarVisibility(.hidden, for: .tabBar)
            }

            Tab(value: .market) {
                MarketView()
                    .toolbarVisibility(.hidden, for: .tabBar)
            }
        }
    }
}

extension InvestTabView {
    struct HomeView: View {
        var body: some View {
            ScrollView {
                LazyVStack {
                    Text("토스증권")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .contentMargins([.horizontal, .bottom], 16, for: .scrollContent)
            .investToolbar()
        }
    }

    struct FavoriteView: View {
        var body: some View {
            ScrollView {
                LazyVStack {
                    Text("관심")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .contentMargins([.horizontal, .bottom], 16, for: .scrollContent)
            .investToolbar()
        }
    }

    struct DiscoverView: View {
        var body: some View {
            ScrollView {
                LazyVStack {
                    Text("발견")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .contentMargins([.horizontal, .bottom], 16, for: .scrollContent)
            .investToolbar()
        }
    }

    struct MarketView: View {
        var body: some View {
            ScrollView {
                LazyVStack {
                    Text("시장")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .contentMargins([.horizontal, .bottom], 16, for: .scrollContent)
            .investToolbar()
        }
    }
}

extension View {
    fileprivate func investToolbar() -> some View {
        self
            .safeAreaBar(edge: .top) {
                HStack(spacing: 16) {
                    Spacer()

                    Group {
                        Image(systemName: "magnifyingglass")

                        Image(systemName: "line.3.horizontal")
                    }
                    .font(.title3)
                }
                .safeAreaPadding(16)
            }
    }
}

#Preview {
    @Previewable @State var selection: InvestTab = .home

    InvestTabView(selection: $selection)
        .safeAreaBar(edge: .bottom) {
            TabBar(selection: $selection) {
                ForEach(InvestTab.allCases) { tab in
                    Label(tab.title, systemImage: tab.symbol)
                        .tag(tab)
                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .bottom
            )
            .padding(21)
            .ignoresSafeArea(.container, edges: .bottom)
        }
}
