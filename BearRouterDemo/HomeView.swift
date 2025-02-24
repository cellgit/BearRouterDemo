//
//  HomeView.swift
//  BearRouterDemo
//
//  Created by admin on 2025/1/24.
//

import SwiftUI
import BearRouter

struct HomeView: View {
    
    @EnvironmentObject private var router: AppRouter
    
    var body: some View {
        // 显示主模块的首页
        
        List {
            NavigationLink(
                "去详情页",
                value: RouteMoudle.main(.detail(message: "Hello SwiftUI!"))
            )
            NavigationLink(
                "去设置页",
                value: RouteMoudle.sub(.settings)
            )
            NavigationLink(
                "个人资料",
                value: RouteMoudle.sub(.profile(userID: "12345"))
            )
        }
        .navigationTitle("首页")
        .sheet(item: $router.presentedRoute) { route in
            // 也用同一个方法构造
            router.destinationView(for: route)
        }
        
        
    }
}

