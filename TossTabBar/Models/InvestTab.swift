//
//  InvestTab.swift
//  TossTabBar
//
//  Created by Huigyun Jeong on 10/13/26.
//

enum InvestTab: String, CaseIterable, Identifiable, Hashable, TabItemRepresentable {
    case home
    case favorite
    case discover
    case market

    var id: String { self.rawValue }

    var title: String {
        switch self {
        case .home:
            return "증권"
        case .favorite:
            return "관심"
        case .discover:
            return "발견"
        case .market:
            return "시장"
        }
    }

    var symbol: String {
        switch self {
        case .home:
            return "chart.line.uptrend.xyaxis"
        case .favorite:
            return "heart"
        case .discover:
            return "magnifyingglass"
        case .market:
            return "widget.grid.2x1.rectangle"
        }
    }
}
