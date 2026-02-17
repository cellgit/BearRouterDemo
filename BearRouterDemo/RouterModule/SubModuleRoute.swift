//
//  SubModuleRoute.swift
//  BearRouterDemo
//

import SwiftUI

/// 子模块的路由
enum SubModuleRoute: Hashable, Sendable {
    case settings
    case profile(userID: String)
}
