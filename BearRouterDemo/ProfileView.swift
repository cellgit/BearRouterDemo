//
//  ProfileView.swift
//  BearRouterDemo
//
//  Created by admin on 2025/1/24.
//

import SwiftUI
import BearRouter

struct ProfileView: View {
    
    @EnvironmentObject private var router: AppRouter
    
    let userID: String
    
    @State private var navigateToDetail = false
    
    
    var body: some View {
        
        VStack {
            Text("子模块的 个人资料，userID = \(userID)")
                .font(.title3)
            
            // 点击按钮触发跳转
            Button("查看详情") {
                router.push(.main(.detail(message: "ProfileView to DetailView")))
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
