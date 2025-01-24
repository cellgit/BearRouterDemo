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
            // 右侧的内容区域，包含 TabView
            TabView {
                // Tab 1: 个人资料视图
                HomeView()
                    .tabItem {
                        Label("主页", systemImage: "person.circle")
                    }
                    .environmentObject(router)  // 让 router 可以在 ProfileView 中访问
                
                // Tab 2: 详情视图
                DetailView(message: "Hello from Detail")
                    .tabItem {
                        Label("详情", systemImage: "doc.text")
                    }
                    .environmentObject(router)  // 让 router 可以在 DetailView 中访问
            }
            .environmentObject(router)  // 在整个 TabView 中共享 router
        }
    }
}
