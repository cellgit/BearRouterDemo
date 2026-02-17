//
//  RouteMoudle.swift
//  BearRouterDemo
//

import SwiftUI

/// 主应用路由类型 — 聚合所有子模块路由
enum RouteMoudle: Hashable, Sendable {
    case main(MainRoute)
    case sub(SubModuleRoute)

    /// 路由 → 视图映射（@ViewBuilder，零 AnyView）
    @ViewBuilder @MainActor
    var destinationView: some View {
        switch self {
        case let .main(route):
            switch route {
            case .home:
                HomeView()
            case let .detail(msg):
                DetailView(message: msg)
            }
        case let .sub(route):
            switch route {
            case .settings:
                SettingsView()
            case let .profile(userID):
                ProfileView(userID: userID)
            }
        }
    }
}
