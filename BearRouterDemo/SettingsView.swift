//
//  SettingsView.swift
//  BearRouterDemo
//

import SwiftUI

struct SettingsView: View {

    @Environment(AppRouter.self) private var router

    var body: some View {
        VStack(spacing: 16) {
            Button("返回上一页") {
                let json = ["name": "张三", "age": 18] as [String: Any]
                router.pop(json)
            }
            .padding()
            .frame(width: 120)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Button("返回根视图") {
                router.popToRoot()
            }
            .padding()
            .frame(width: 120)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .navigationTitle("设置")
    }
}
