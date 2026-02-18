//
//  DetailView.swift
//  BearRouterDemo
//

import SwiftUI

/// 详情页 — `.zoom` 过渡的目标视图
///
/// 从 HomeView 的卡片缩放展开进入此页面。
/// 返回手势：
///   - ↓ 从上向下滑动（zoom 过渡特有）
///   - ← 从左边缘向右侧滑（标准导航返回）
struct DetailView: View {

    let message: String
    @Environment(AppRouter.self) private var router

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Hero — zoom 过渡时参与几何动画
                RoundedRectangle(cornerRadius: 20)
                    .fill(.linearGradient(
                        colors: [.blue.opacity(0.6), .purple.opacity(0.6)],
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    ))
                    .frame(height: 200)
                    .overlay {
                        VStack(spacing: 8) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 40))
                            Text(message).font(.title2.bold())
                        }
                        .foregroundStyle(.white)
                    }

                VStack(alignment: .leading, spacing: 12) {
                    Text("交互手势说明").font(.headline)
                    infoRow(icon: "hand.draw.fill",        text: "← 左边缘向右侧滑返回", color: .orange)
                    infoRow(icon: "arrow.down",            text: "↓ 从上向下拖拽返回",    color: .blue)
                    infoRow(icon: "arrow.uturn.backward",  text: "点击按钮程序化返回",     color: .green)
                }
                .padding(.horizontal)

                VStack(spacing: 12) {
                    Button { router.pop() } label: {
                        Label("返回上一页", systemImage: "arrow.left")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)

                    Button { router.popToRoot() } label: {
                        Label("返回根视图", systemImage: "arrow.uturn.backward")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)

                    Button {
                        router.push(.sub(.settings)) { data in
                            print("设置页返回数据: \(String(describing: data))")
                        }
                    } label: {
                        Label("去设置页（Slide 过渡）", systemImage: "gearshape")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)

                Spacer(minLength: 40)
            }
        }
        .navigationTitle("详情")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func infoRow(icon: String, text: String, color: Color) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon).foregroundStyle(color).frame(width: 28)
            Text(text).font(.subheadline)
        }
    }
}
