//
//  ProfileView.swift
//  BearRouterDemo
//
//  Created by admin on 2025/1/24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var router: AppRouter
    
    let userID: String
    
    var body: some View {
        
        VStack {
            Text("子模块的 个人资料，userID = \(userID)")
                .font(.title3)
            
            // 点击按钮跳转到详情页面
            NavigationLink(value: AnyHashable(RouteMoudle.main(.detail(message: userID)))) {
                Text("查看详情")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            
            // 点击按钮触发跳转
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
