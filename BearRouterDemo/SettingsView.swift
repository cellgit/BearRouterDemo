//
//  SettingsView.swift
//  BearRouterDemo
//

import SwiftUI

/// 设置页 — `.slide` 过渡目标
///
/// 标准水平推入动画。返回手势：← 左侧滑
struct SettingsView: View {

    @Environment(AppRouter.self) private var router

    var body: some View {
        List {
            Section("过渡说明") {
                Label("本页使用标准 Slide 过渡", systemImage: "arrow.right.square")
                Label("← 从左边缘向右侧滑可返回", systemImage: "hand.point.left.fill")
            }

            Section("操作") {
                Button {
                    let json = ["name": "张三", "age": 18] as [String: Any]
                    router.pop(json)
                } label: {
                    Label("返回上一页（带数据）", systemImage: "arrow.left.circle")
                }

                Button {
                    router.popToRoot()
                } label: {
                    Label("返回根视图", systemImage: "arrow.uturn.backward.circle")
                }

                Button(role: .destructive) {
                    router.dismissAll()
                } label: {
                    Label("关闭所有", systemImage: "xmark.circle")
                }
            }
        }
        .navigationTitle("设置")
    }
}
