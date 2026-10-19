//
//  TabSelection.swift
//  TossTabBar
//
//  Created by Huigyun Jeong on 10/19/26.
//

enum TabSelection: Identifiable, Hashable, TabItemRepresentable {
    case root(RootTab)
    case invest(InvestTab)

    var id: String {
        switch self {
        case .root(let tab):
            return tab.id
        case .invest(let tab):
            return tab.id
        }
    }

    var title: String {
        switch self {
        case .root(let tab):
            return tab.title
        case .invest(let tab):
            return tab.title
        }
    }

    var symbol: String {
        switch self {
        case .root(let tab):
            return tab.symbol
        case .invest(let tab):
            return tab.symbol
        }
    }
}
