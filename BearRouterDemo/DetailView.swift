//
//  DetailView.swift
//  BearRouterDemo
//
//  Created by admin on 2025/1/24.
//

import SwiftUI
import BearRouter

struct DetailView: View {
    
    let message: String
    
    @EnvironmentObject var router: AppRouter  // 注入 Router 实例
    
    var body: some View {
        
        VStack(spacing: 16) {
            Text("参数 message: \(message)")
                .font(.title3)
            
            Button("返回根视图") {
                router.popToRoot()
            }
            .padding()
            .frame(width: 120)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Button("去设置页") {
                router.push(.sub(.settings)) { data in
                    print("传递的数据: \(String(describing: data))")
                }
            }
            .padding()
            .frame(width: 120)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .navigationTitle("详情")
        
        
    }
}
