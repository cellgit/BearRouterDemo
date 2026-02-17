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
