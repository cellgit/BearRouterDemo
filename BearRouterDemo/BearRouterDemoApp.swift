//
//  BearRouterDemoApp.swift
//  BearRouterDemo
//

import SwiftUI
import BearRouter
import BearRouterCore

@main
struct BearRouterDemoApp: App {

    @State private var router = AppRouter()

    var body: some Scene {
        WindowGroup {
            TabNavigationHost(
                navigator: router.tabNavigator,
                tabs: [
                    NavigableTab(tabID: AppTab.home) {
                        Label("主页", systemImage: "house.fill")
                    } content: {
                        HomeView()
                    }.eraseToAny(),
                    NavigableTab(tabID: AppTab.detail) {
                        Label("设置", systemImage: "gearshape.fill")
                    } content: {
                        SettingsView()
                    }.eraseToAny()
                ],
                // ✅ 传入过渡样式闭包 — BearRouter 自动对 zoom 路由应用 matchedTransitionSource
                transitionStyle: { route in route.transitionStyle }
            ) { route in
                route.destinationView
            }
            .environment(router)
            .onOpenURL { url in
                router.handleDeepLink(url)
            }
        }
    }
}
