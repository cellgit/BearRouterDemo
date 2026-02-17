//
//  ProfileView.swift
//  BearRouterDemo
//

import SwiftUI

struct ProfileView: View {

    @Environment(AppRouter.self) private var router

    let userID: String

    var body: some View {
        VStack {
            Text("子模块的 个人资料，userID = \(userID)")
                .font(.title3)

            NavigationLink(value: RouteMoudle.main(.detail(message: userID))) {
                Text("查看详情")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            Button("查看详情") {
                router.push(.main(.detail(message: userID)))
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding()
        }
        .navigationTitle("个人资料")
    }
}
