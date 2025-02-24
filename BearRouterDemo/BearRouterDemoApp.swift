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
    
    @State private var selectedTab: Int = 0
    
    var body: some Scene {
        WindowGroup {
            // 右侧的内容区域，包含 TabView
            TabView(selection: $selectedTab) {
                // Tab 1: 个人资料视图
                NavigationStack(path: $router.navigationPath) {
                    HomeView()
                        .navigationDestination(for: RouteMoudle.self) {
                            router.destinationView(for: $0)
                        }
                }
                .tabItem {
                    Label("主页", systemImage: "person.circle")
                }
                .tag(0)
                
                NavigationStack(path: $router.navigationPath) {
                    // Tab 2: 详情视图
                    DetailView(message: "Hello from Detail")
                        .navigationDestination(for: RouteMoudle.self) {
                            router.destinationView(for: $0)
                        }
                }
                .tabItem {
                    Label("详情", systemImage: "doc.text")
                }
                .tag(1)
            }
            .environmentObject(router)
            .onChange(of: selectedTab) { oldValue, newValue in
                router.popToRoot()
            }
        }
    }
}
