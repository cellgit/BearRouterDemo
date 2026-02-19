//
//  HomeView.swift
//  BearRouterDemo
//

import SwiftUI
import BearRouter

/// 主页 — 展示 BearRouter 的 `matchedTransitionSource` zoom 过渡
///
/// 使用方式很简单，只需两步：
/// 1. 在源视图上添加 `.bearTransitionSource(id:)` 标记
/// 2. 在 `RouteMoudle.transitionStyle` 中将该路由设为 `.zoom`
///
/// BearRouter 的 Host 视图会自动完成 `@Namespace` 注入
/// 和 `.navigationTransition(.zoom(sourceID:in:))` 的应用。
struct HomeView: View {

    @Environment(AppRouter.self) private var router

    private let items: [(id: Int, title: String, icon: String, color: Color)] = [
        (1, "SwiftUI 动画",  "wand.and.stars",        .blue),
        (2, "导航过渡",      "arrow.triangle.swap",   .purple),
        (3, "手势交互",      "hand.draw.fill",        .orange),
        (4, "状态管理",      "gearshape.2.fill",      .green),
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // MARK: - Zoom 过渡示例（卡片 → 详情）
                Text("Zoom 过渡").font(.title3.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("点击卡片，缩放展开进入详情页\n返回: ↓ 下滑 或 ← 左侧滑")
                    .font(.caption).foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                LazyVGrid(columns: [.init(.flexible()), .init(.flexible())], spacing: 12) {
                    ForEach(items, id: \.id) { item in
                        NavigationLink(value: RouteMoudle.main(.detail(message: item.title))) {
                            cardView(item: item)
                        }
                        .buttonStyle(.plain)
                        // ✅ 标记为 zoom 过渡的源视图
                        .bearTransitionSource(
                            id: RouteMoudle.main(.detail(message: item.title))
                        )
                    }
                }

                Divider().padding(.vertical, 8)

                // MARK: - Slide 过渡示例
                Text("Slide 过渡").font(.title3.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("标准水平推入，返回: ← 左侧滑")
                    .font(.caption).foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)

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
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)

                Divider().padding(.vertical, 8)

                // MARK: - Zoom 过渡 — 个人资料
                Text("Zoom 过渡 — 个人资料").font(.title3.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("从头像行缩放进入")
                    .font(.caption).foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                profileRow(userID: "10086", name: "张三", color: .cyan)
                profileRow(userID: "10010", name: "李四", color: .mint)
            }
            .padding(.horizontal)
        }
        .navigationTitle("BearRouter 示例")
    }

    // MARK: - Subviews

    private func cardView(item: (id: Int, title: String, icon: String, color: Color)) -> some View {
        VStack(spacing: 8) {
            Image(systemName: item.icon)
                .font(.largeTitle)
                .foregroundStyle(item.color)
            Text(item.title)
                .font(.subheadline.bold())
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .padding()
        .background(item.color.opacity(0.1), in: RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(item.color.opacity(0.3), lineWidth: 1)
        )
    }

    private func profileRow(userID: String, name: String, color: Color) -> some View {
        NavigationLink(value: RouteMoudle.sub(.profile(userID: userID))) {
            HStack(spacing: 12) {
                Circle()
                    .fill(color.gradient)
                    .frame(width: 44, height: 44)
                    .overlay {
                        Text(String(name.prefix(1)))
                            .font(.headline).foregroundStyle(.white)
                    }
                VStack(alignment: .leading) {
                    Text(name).font(.headline)
                    Text("ID: \(userID)").font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right").foregroundStyle(.tertiary)
            }
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
            // ✅ 标记为 zoom 过渡的源视图（放在 label 内部）
            .bearTransitionSource(id: RouteMoudle.sub(.profile(userID: userID)))
        }
        .buttonStyle(.plain)
    }
}
