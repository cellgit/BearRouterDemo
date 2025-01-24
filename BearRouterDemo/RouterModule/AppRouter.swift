//
//  AppRouter.swift
//  BearRouterDemo
//
//  Created by admin on 2025/1/24.
//

import SwiftUI
import BearRouter

/// 主应用路由器，继承基础路由逻辑,且遵循视图映射和深链处理
class AppRouter: BearRouter<RouteMoudle>, ViewMapping, DeepLinkHandler {
    
    // 路由到视图的映射
    func destinationView(for route: RouteMoudle) -> AnyView {
        switch route {
        case let .main(mainRoute):
            return mainRoute.destinationView()
        case let .sub(subRoute):
            return subRoute.destinationView()
        }
    }
    
    /// 深链处理
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
