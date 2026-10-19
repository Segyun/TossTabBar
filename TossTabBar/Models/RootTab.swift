//
//  RootTab.swift
//  TossTabBar
//
//  Created by Huigyun Jeong on 10/9/26.
//

enum RootTab: String, CaseIterable, Identifiable, Hashable, TabItemRepresentable {
    case home
    case benefit
    case shopping
    case invest
    case all

    var id: String { self.rawValue }

    var title: String {
        switch self {
        case .home:
            return "홈"
        case .benefit:
            return "혜택"
        case .shopping:
            return "쇼핑"
        case .invest:
            return "증권"
        case .all:
            return "전체"
        }
    }

    var symbol: String {
        switch self {
        case .home:
            return "house"
        case .benefit:
            return "suit.diamond"
        case .shopping:
            return "cart"
        case .invest:
            return "chart.line.uptrend.xyaxis"
        case .all:
            return "line.3.horizontal"
        }
    }
}
