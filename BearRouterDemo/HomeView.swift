//
//  HomeView.swift
//  BearRouterDemo
//
//  Created by admin on 2025/1/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        List {
            NavigationLink(
                "去详情页",
                value: AnyHashable(RouteMoudle.main(.detail(message: "Hello SwiftUI!")))
            )
            NavigationLink(
                "去设置页",
                value: AnyHashable(RouteMoudle.sub(.settings))
            )
            NavigationLink(
                "个人资料",
                value: AnyHashable(RouteMoudle.sub(.profile(userID: "12345")))
            )
        }
        .navigationTitle("首页")
    }
}
