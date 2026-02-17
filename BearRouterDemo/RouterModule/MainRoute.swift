//
//  MainRoute.swift
//  BearRouterDemo
//

import SwiftUI

/// 主模块的路由
enum MainRoute: Hashable, Sendable {
    case home
    case detail(message: String)
}
