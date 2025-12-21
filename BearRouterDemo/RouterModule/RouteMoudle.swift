//
//  AppRoute.swift
//  BearRouterDemo
//
//  Created by admin on 2025/1/24.
//

/// 主应用路由类型
enum RouteMoudle: Hashable, Sendable {
    case main(MainRoute)
    case sub(SubModuleRoute)
    
    var id: String {
        switch self {
        case let .main(m):
            return "AppRoute_main_\(m.id)"
        case let .sub(s):
            return "AppRoute_sub_\(s.id)"
        }
    }
}
