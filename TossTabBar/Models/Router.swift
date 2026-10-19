//
//  Router.swift
//  TossTabBar
//
//  Created by Huigyun Jeong on 10/13/26.
//

import Foundation

@Observable
@MainActor
final class Router {
    private(set) var currentSelection: TabSelection
    private(set) var lastRootTab: RootTab
    private(set) var lastInvestTab: InvestTab

    init() {
        self.currentSelection = .root(.home)
        self.lastRootTab = .home
        self.lastInvestTab = .home
    }

    var rootSelection: RootTab {
        get {
            switch currentSelection {
            case .root(let tab):
                return tab
            case .invest:
                return .invest
            }
        }
        set {
            selectRootTab(newValue)
        }
    }

    var investSelection: InvestTab {
        get {
            switch currentSelection {
            case .root:
                return lastInvestTab
            case .invest(let tab):
                return tab
            }
        }
        set {
            selectInvestTab(newValue)
        }
    }

    var tabBarSelection: TabSelection {
        get { currentSelection }
        set { select(newValue) }
    }

    var canGoBack: Bool {
        if case .invest = currentSelection { return true }
        return false
    }

    var visibleTabs: [TabSelection] {
        switch currentSelection {
        case .root:
            return RootTab.allCases.map(TabSelection.root)
        case .invest:
            return InvestTab.allCases.map(TabSelection.invest)
        }
    }

    func selectRootTab(_ tab: RootTab) {
        guard tab != .invest else {
            currentSelection = .invest(lastInvestTab)
            return
        }

        lastRootTab = tab
        currentSelection = .root(tab)
    }

    func selectInvestTab(_ tab: InvestTab) {
        lastInvestTab = tab
        currentSelection = .invest(tab)
    }

    func select(_ selection: TabSelection) {
        switch selection {
        case .root(let tab):
            selectRootTab(tab)
        case .invest(let tab):
            selectInvestTab(tab)
        }
    }

    func goBack() {
        guard canGoBack else { return }
        currentSelection = .root(lastRootTab)
    }
}
