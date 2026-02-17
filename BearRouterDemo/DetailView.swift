//
//  DetailView.swift
//  BearRouterDemo
//

import SwiftUI

struct DetailView: View {

    let message: String

    @Environment(AppRouter.self) private var router

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
