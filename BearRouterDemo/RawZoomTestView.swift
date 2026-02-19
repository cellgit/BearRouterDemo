//
//  RawZoomTestView.swift
//  BearRouterDemo
//
//  纯 SwiftUI 诊断视图 — 不使用 BearRouter
//  用于确认 zoom 转场 opacity bug 是 SwiftUI 框架问题还是 BearRouter 封装问题
//
//  测试步骤：
//  1. 点击任意卡片 → zoom 进入详情
//  2. 使用系统 Back 按钮返回 → 观察卡片是否正常显示 ✅
//  3. 再次点击同一卡片 → zoom 进入详情
//  4. 使用 **交互手势** 返回（← 左侧滑 或 ↓ 下滑）
//  5. 观察卡片是否消失（opacity 卡在 0）❌
//
//  如果此视图也出现问题 → SwiftUI 框架 bug
//  如果此视图正常 → BearRouter 封装导致的问题

import SwiftUI

// MARK: - 纯 SwiftUI 测试（方案 A：@State path + 本地 @Namespace）

struct RawZoomTestView: View {
    @State private var path: [String] = []
    @Namespace private var namespace

    private let items = [
        ("SwiftUI 动画", "wand.and.stars", Color.blue),
        ("导航过渡", "arrow.triangle.swap", Color.purple),
        ("手势交互", "hand.draw.fill", Color.orange),
        ("状态管理", "gearshape.2.fill", Color.green),
    ]

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(spacing: 16) {
                    Text("方案 A: @State + 本地 @Namespace")
                        .font(.headline)
                    Text("纯 SwiftUI，无 BearRouter")
                        .font(.caption).foregroundStyle(.secondary)

                    LazyVGrid(columns: [.init(.flexible()), .init(.flexible())], spacing: 12) {
                        ForEach(items, id: \.0) { item in
                            NavigationLink(value: item.0) {
                                VStack(spacing: 8) {
                                    Image(systemName: item.1)
                                        .font(.largeTitle)
                                        .foregroundStyle(item.2)
                                    Text(item.0)
                                        .font(.subheadline.bold())
                                }
                                .frame(maxWidth: .infinity, minHeight: 100)
                                .padding()
                                .background(item.2.opacity(0.1), in: RoundedRectangle(cornerRadius: 16))
                            }
                            .buttonStyle(.plain)
                            .matchedTransitionSource(id: item.0, in: namespace)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("诊断: 纯 SwiftUI")
            .navigationDestination(for: String.self) { item in
                ZoomDetailTestView(title: item)
                    .navigationTransition(.zoom(sourceID: item, in: namespace))
            }
        }
    }
}

// MARK: - 方案 B：@Observable 管理 path（模拟 BearRouter 的 Navigator 模式）

@Observable
@MainActor
private final class TestNavigator {
    var path: [String] = []
}

struct ObservableZoomTestView: View {
    @State private var navigator = TestNavigator()
    @Namespace private var namespace

    private let items = [
        ("SwiftUI 动画", "wand.and.stars", Color.blue),
        ("导航过渡", "arrow.triangle.swap", Color.purple),
        ("手势交互", "hand.draw.fill", Color.orange),
        ("状态管理", "gearshape.2.fill", Color.green),
    ]

    var body: some View {
        @Bindable var nav = navigator
        NavigationStack(path: $nav.path) {
            ScrollView {
                VStack(spacing: 16) {
                    Text("方案 B: @Observable + @Bindable")
                        .font(.headline)
                    Text("@Observable 管理 path，本地 @Namespace")
                        .font(.caption).foregroundStyle(.secondary)

                    LazyVGrid(columns: [.init(.flexible()), .init(.flexible())], spacing: 12) {
                        ForEach(items, id: \.0) { item in
                            NavigationLink(value: item.0) {
                                VStack(spacing: 8) {
                                    Image(systemName: item.1)
                                        .font(.largeTitle)
                                        .foregroundStyle(item.2)
                                    Text(item.0)
                                        .font(.subheadline.bold())
                                }
                                .frame(maxWidth: .infinity, minHeight: 100)
                                .padding()
                                .background(item.2.opacity(0.1), in: RoundedRectangle(cornerRadius: 16))
                            }
                            .buttonStyle(.plain)
                            .matchedTransitionSource(id: item.0, in: namespace)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("诊断: @Observable")
            .navigationDestination(for: String.self) { item in
                ZoomDetailTestView(title: item)
                    .navigationTransition(.zoom(sourceID: item, in: namespace))
            }
        }
    }
}

// MARK: - 方案 C：手动 Binding（模拟 BearRouter 当前的 pathBinding() 模式）

struct ManualBindingZoomTestView: View {
    @State private var navigator = TestNavigator()
    @Namespace private var namespace

    private let items = [
        ("SwiftUI 动画", "wand.and.stars", Color.blue),
        ("导航过渡", "arrow.triangle.swap", Color.purple),
        ("手势交互", "hand.draw.fill", Color.orange),
        ("状态管理", "gearshape.2.fill", Color.green),
    ]

    var body: some View {
        NavigationStack(path: manualPathBinding()) {
            ScrollView {
                VStack(spacing: 16) {
                    Text("方案 C: 手动 Binding(get:set:)")
                        .font(.headline)
                    Text("手动创建 Binding，模拟 BearRouter 的 pathBinding()")
                        .font(.caption).foregroundStyle(.secondary)

                    LazyVGrid(columns: [.init(.flexible()), .init(.flexible())], spacing: 12) {
                        ForEach(items, id: \.0) { item in
                            NavigationLink(value: item.0) {
                                VStack(spacing: 8) {
                                    Image(systemName: item.1)
                                        .font(.largeTitle)
                                        .foregroundStyle(item.2)
                                    Text(item.0)
                                        .font(.subheadline.bold())
                                }
                                .frame(maxWidth: .infinity, minHeight: 100)
                                .padding()
                                .background(item.2.opacity(0.1), in: RoundedRectangle(cornerRadius: 16))
                            }
                            .buttonStyle(.plain)
                            .matchedTransitionSource(id: item.0, in: namespace)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("诊断: 手动 Binding")
            .navigationDestination(for: String.self) { item in
                ZoomDetailTestView(title: item)
                    .navigationTransition(.zoom(sourceID: item, in: namespace))
            }
        }
    }

    /// 模拟 BearRouter 的 pathBinding() 方式
    private func manualPathBinding() -> Binding<[String]> {
        Binding(
            get: { navigator.path },
            set: { navigator.path = $0 }
        )
    }
}

// MARK: - 方案 D：@Environment 传递 Namespace（模拟 BearRouter 的 environment 方式）

private struct TestNamespaceKey: EnvironmentKey {
    static let defaultValue: Namespace.ID? = nil
}

private extension EnvironmentValues {
    var testNamespace: Namespace.ID? {
        get { self[TestNamespaceKey.self] }
        set { self[TestNamespaceKey.self] = newValue }
    }
}

struct EnvironmentNamespaceZoomTestView: View {
    @State private var path: [String] = []
    @Namespace private var namespace

    private let items = [
        ("SwiftUI 动画", "wand.and.stars", Color.blue),
        ("导航过渡", "arrow.triangle.swap", Color.purple),
        ("手势交互", "hand.draw.fill", Color.orange),
        ("状态管理", "gearshape.2.fill", Color.green),
    ]

    var body: some View {
        NavigationStack(path: $path) {
            EnvNamespaceGridView(items: items)
                .environment(\.testNamespace, namespace)
                .navigationDestination(for: String.self) { item in
                    ZoomDetailTestView(title: item)
                        .navigationTransition(.zoom(sourceID: item, in: namespace))
                }
        }
    }
}

private struct EnvNamespaceGridView: View {
    let items: [(String, String, Color)]
    @Environment(\.testNamespace) private var namespace

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("方案 D: @Environment 传递 Namespace")
                    .font(.headline)
                Text("Namespace 通过环境注入（模拟 BearRouter）")
                    .font(.caption).foregroundStyle(.secondary)

                LazyVGrid(columns: [.init(.flexible()), .init(.flexible())], spacing: 12) {
                    ForEach(items, id: \.0) { item in
                        NavigationLink(value: item.0) {
                            VStack(spacing: 8) {
                                Image(systemName: item.1)
                                    .font(.largeTitle)
                                    .foregroundStyle(item.2)
                                Text(item.0)
                                    .font(.subheadline.bold())
                            }
                            .frame(maxWidth: .infinity, minHeight: 100)
                            .padding()
                            .background(item.2.opacity(0.1), in: RoundedRectangle(cornerRadius: 16))
                        }
                        .buttonStyle(.plain)
                        .modifier(ConditionalMTSModifier(id: item.0, namespace: namespace))
                    }
                }
            }
            .padding()
        }
        .navigationTitle("诊断: Env Namespace")
    }
}

private struct ConditionalMTSModifier: ViewModifier {
    let id: String
    let namespace: Namespace.ID?

    func body(content: Content) -> some View {
        if let namespace {
            content.matchedTransitionSource(id: id, in: namespace)
        } else {
            content
        }
    }
}

// MARK: - 共用详情页

struct ZoomDetailTestView: View {
    let title: String

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.green)

            Text(title)
                .font(.title.bold())

            Text("Zoom 过渡详情页")
                .font(.headline).foregroundStyle(.secondary)

            Text("测试交互手势返回：\n• ← 左侧边缘滑动\n• ↓ 从顶部下滑\n\n返回后观察源卡片是否可见")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
        }
        .padding()
        .navigationTitle("详情")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - 诊断入口（选择方案）

struct ZoomDiagnosticView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("诊断测试") {
                    NavigationLink("方案 A: @State + 本地 Namespace") {
                        RawZoomTestView()
                    }
                    NavigationLink("方案 B: @Observable + @Bindable") {
                        ObservableZoomTestView()
                    }
                    NavigationLink("方案 C: 手动 Binding(get:set:)") {
                        ManualBindingZoomTestView()
                    }
                    NavigationLink("方案 D: Environment Namespace") {
                        EnvironmentNamespaceZoomTestView()
                    }
                }

                Section("说明") {
                    Text("每个方案测试不同的实现模式。\n\n对每个方案执行：\n1. 点击卡片进入\n2. 用交互手势返回（← 或 ↓）\n3. 重复 2-3 次\n4. 观察卡片是否消失\n\n如果所有方案都有问题 → SwiftUI 框架 bug\n如果只有 C/D 有问题 → BearRouter 的 Binding/Environment 模式导致")
                        .font(.caption)
                }
            }
            .navigationTitle("Zoom 转场诊断")
        }
    }
}
