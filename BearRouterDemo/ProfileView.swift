//
//  ProfileView.swift
//  BearRouterDemo
//

import SwiftUI
import BearRouter

/// 个人资料页 — `.zoom` 过渡目标
///
/// 从 HomeView 的头像行缩放展开进入。
/// 返回手势：↓ 下滑 + ← 侧滑
struct ProfileView: View {

    @Environment(AppRouter.self) private var router
    let userID: String

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Circle()
                    .fill(.purple.gradient)
                    .frame(width: 100, height: 100)
                    .overlay {
                        Image(systemName: "person.fill")
                            .font(.system(size: 44)).foregroundStyle(.white)
                    }
                    .padding(.top, 20)

                Text("用户 ID: \(userID)").font(.title2.bold())
                Text("Zoom 过渡进入\n↓ 下滑返回 · ← 侧滑返回")
                    .font(.subheadline).foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                Divider()

                // 从 ProfileView 继续导航到 DetailView（也用 zoom）
                VStack(spacing: 12) {
                    Text("继续导航").font(.headline)

                    NavigationLink(value: RouteMoudle.main(.detail(message: "来自 \(userID) 的详情"))) {
                        HStack {
                            Image(systemName: "doc.text.fill")
                            Text("查看详情（Zoom）")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding()
                        .background(.blue.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
                    }
                    .buttonStyle(.plain)
                    // ✅ 标记为下一级 zoom 过渡的源
                    .bearTransitionSource(
                        id: RouteMoudle.main(.detail(message: "来自 \(userID) 的详情"))
                    )

                    Button {
                        router.push(.sub(.settings))
                    } label: {
                        HStack {
                            Image(systemName: "gearshape.fill")
                            Text("去设置页（Slide）")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding()
                        .background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal)

                Spacer(minLength: 40)
            }
        }
        .navigationTitle("个人资料")
        .navigationBarTitleDisplayMode(.inline)
    }
}
