//
//  BearRouterDemoApp.swift
//  BearRouterDemo
//
//  Created by admin on 2025/1/24.
//

import SwiftUI
import BearRouter

@main
struct BearRouterDemoApp: App {
    
    @StateObject private var router = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            TabNavigationHost(
                navigator: router.tabNavigator,
                registry: router.registry,
                tabs: [
                    NavigableTab(tabID: AppTab.home) {
                        Label("主页", systemImage: "person.circle")
                    } content: {
                        HomeView()
                    }.eraseToAny(),
                    NavigableTab(tabID: AppTab.detail) {
                        Label("详情", systemImage: "doc.text")
                    } content: {
                        DetailView(message: "Hello from Detail")
                    }.eraseToAny()
                ]
            )
            .environmentObject(router)
            .onOpenURL { url in
                router.handleDeepLink(url)
            }
        }
    }
}
