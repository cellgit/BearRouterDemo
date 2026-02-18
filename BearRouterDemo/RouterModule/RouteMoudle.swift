//
//  RouteMoudle.swift
//  BearRouterDemo
//

import SwiftUI
import BearRouter

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

    /// 每个路由的过渡动画样式
    ///
    /// - `.zoom`  → 从源视图缩放展开，支持 ↓ 下滑 + ← 侧滑 两种手势返回
    /// - `.slide` → 标准水平推入，仅支持 ← 侧滑返回
    var transitionStyle: BearTransitionStyle {
        switch self {
        case .main(.detail):   .zoom   // 详情页：zoom 过渡
        case .sub(.profile):   .zoom   // 个人资料：zoom 过渡
        case .sub(.settings):  .slide  // 设置页：标准 slide
        case .main(.home):     .automatic
        }
    }
}
