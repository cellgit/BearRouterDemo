//
//  SubModuleRoute.swift
//  BearRouterDemo
//
//  Created by admin on 2025/1/24.
//

import SwiftUI

/// 子模块的路由
enum SubModuleRoute: Hashable, Sendable {
    case settings
    case profile(userID: String)

    // 用于调试或日志标识
    var id: String {
        switch self {
        case .settings:
            return "sub_settings"
        case let .profile(userID):
            return "sub_profile_\(userID)"
        }
    }
}

extension SubModuleRoute {
    func destinationView() -> AnyView {
        switch self {
        case .settings:
            return AnyView(SettingsView())
        case let .profile(userID):
            return AnyView(ProfileView(userID: userID))
        }
    }
}
