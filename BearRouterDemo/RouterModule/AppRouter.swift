//
//  AppRouter.swift
//  BearRouterDemo
//

import SwiftUI
import Observation
import BearRouter
import BearRouterCore

enum AppTab: Hashable, Sendable {
    case home
    case detail
}

@Observable
@MainActor
final class AppRouter {
    let tabNavigator: TabNavigator<AppTab, RouteMoudle>

    @ObservationIgnored
    private var returnHandlers: [((Any?) -> Void)?] = []

    init() {
        tabNavigator = TabNavigator<AppTab, RouteMoudle>()
    }

    // MARK: - Navigation

    func push(_ route: RouteMoudle, onReturn: ((Any?) -> Void)? = nil) {
        returnHandlers.append(onReturn)
        Task { @MainActor in
            await tabNavigator.handle(.navigateCurrent(.push(route)))
        }
    }

    func pop(_ data: Any? = nil) {
        if !returnHandlers.isEmpty {
            let handler = returnHandlers.removeLast()
            handler?(data)
        }
        Task { @MainActor in
            await tabNavigator.handle(.navigateCurrent(.pop))
        }
    }

    func popToRoot() {
        returnHandlers.removeAll()
        Task { @MainActor in
            await tabNavigator.handle(.navigateCurrent(.popToRoot))
        }
    }

    func dismissAll() {
        returnHandlers.removeAll()
        Task { @MainActor in
            await tabNavigator.handle(.navigateCurrent(.dismissAll))
        }
    }

    // MARK: - Deep Link

    func handleDeepLink(_ url: URL) {
        guard let routerPath = url.routerPath, !routerPath.isEmpty else {
            print("Invalid deep link URL: \(url)")
            return
        }

        let params = url.queryParameters
        switch routerPath {
        case "detail":
            if let msg = params["message"] {
                push(.main(.detail(message: msg)))
            }
        case "profile":
            if let userID = params["userID"] {
                push(.sub(.profile(userID: userID)))
            }
        case "settings":
            push(.sub(.settings))
        default:
            print("Unhandled deep link: \(routerPath)")
        }
    }
}

private extension URL {
    var routerPath: String? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }
        let trimmed = components.path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        if !trimmed.isEmpty {
            return trimmed
        }
        if let host = components.host, !host.isEmpty {
            return host
        }
        return nil
    }

    var queryParameters: [String: String] {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
              let items = components.queryItems else {
            return [:]
        }
        return items.reduce(into: [String: String]()) { partial, item in
            if let value = item.value {
                partial[item.name] = value
            }
        }
    }
}
