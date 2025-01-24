//
//  SettingsView.swift
//  BearRouterDemo
//
//  Created by admin on 2025/1/24.
//

import SwiftUI
import BearRouter

struct SettingsView: View {
    
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        
        Button("返回上一页") {
//            router.pop()
            
            let json = ["name": "张三", "age": 18] as [String : Any]
            router.pop(json)
        }
        .padding()
        .frame(width: 120)
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(8)
        .navigationTitle("设置")
        
        Button("返回根视图") {
            router.popToRoot()
        }
        .padding()
        .frame(width: 120)
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}
