//
//  ProfileView.swift
//  BearRouterDemo
//
//  Created by admin on 2025/1/24.
//

import SwiftUI
import BearRouter

struct ProfileView: View {
    
    let userID: String
    
    @State private var navigateToDetail = false
    
    
    var body: some View {
        
        VStack {
            Text("子模块的 个人资料，userID = \(userID)")
                .font(.title3)
            
            // 点击按钮跳转到详情页面
            NavigationLink(destination: DetailView(message:  userID)) {
                Text("查看详情")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            
            // 点击按钮触发跳转
            Button("查看详情") {
                navigateToDetail = true  // 改变状态，触发跳转
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding()
            
        }
        .navigationTitle("个人资料")
        .navigationDestination(isPresented: $navigateToDetail) {
            DetailView(message: userID)  // 跳转到 DetailView
        }
        
    }
    
}
