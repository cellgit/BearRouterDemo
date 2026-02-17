//
//  HomeView.swift
//  BearRouterDemo
//

import SwiftUI

struct HomeView: View {
    var body: some View {
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
    }
}
