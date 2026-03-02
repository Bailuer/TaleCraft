import SwiftUI
import RealityKit
import ARKit
import PencilKit

// MARK: - 1. 核心状态管理器
// 用于在 SwiftUI、PencilKit 和 RealityKit 之间传递数据
class AppState: ObservableObject {
    // 持有 ARView 的引用，以便 PencilKit 能向其中发射射线
    weak var arView: ARView?
    @Published var message: String = "请移动设备扫描地面..."
}

struct ContentView: View {
    @StateObject var appState = AppState()
    @State private var canvasView = PKCanvasView()

    var body: some View {
        ZStack {
            // Layer 1: AR 世界 (底层)
            ARViewContainer(appState: appState)
                .edgesIgnoringSafeArea(.all)
            
            // Layer 2: 绘画画布 (顶层透明)
            PencilKitContainer(canvasView: $canvasView, appState: appState)
                .allowsHitTesting(true) // 允许触摸绘画
            
            // Layer 3: UI 提示
            VStack {
                Text(appState.message)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .padding(.top, 50)
                
                Spacer()
                
                Button(action: {
                    canvasView.drawing = PKDrawing() // 清空画布
                    appState.arView?.scene.anchors.removeAll() // 清空 3D 物体
                }) {
                    Image(systemName: "trash")
                        .font(.largeTitle)
                        .padding()
                        .background(.white)
                        .clipShape(Circle())
                }
                .padding(.bottom, 30)
            }
        }
    }
}

// MARK: - 2. RealityKit 容器 (3D 世界)
struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var appState: AppState
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // 配置 AR 会话：检测水平面
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        config.environmentTexturing = .automatic
        arView.session.run(config)
        
        // 将 ARView 引用传给 State，让 PencilKit 能访问
        appState.arView = arView
        
        // 添加一个 Coache Overlay (引导用户扫描地面)
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = arView.session
        coachingOverlay.goal = .horizontalPlane
        arView.addSubview(coachingOverlay)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}

// MARK: - 3. PencilKit 容器 (2D 绘画)
struct PencilKitContainer: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    @ObservedObject var appState: AppState
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput // 允许手指和笔
        canvasView.backgroundColor = .clear // 关键：背景透明
        canvasView.isOpaque = false
        canvasView.tool = PKInkingTool(.marker, color: .systemYellow, width: 10)
        canvasView.delegate = context.coordinator
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // MARK: - 核心逻辑 Coordinator
    class Coordinator: NSObject, PKCanvasViewDelegate {
        var parent: PencilKitContainer
        
        init(_ parent: PencilKitContainer) {
            self.parent = parent
        }
        
        // 当用户绘画状态改变时调用
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            // 我们只在笔触结束时触发逻辑，避免连续触发
            // 注意：PencilKit 没有直接的 "didEndStroke" 代理，
            // 这里简化处理：只要有笔画，我们就尝试转换，然后清空，模拟“转化”效果
            
            guard let lastStroke = canvasView.drawing.strokes.last else { return }
            
            // 1. 获取笔触中心点 (2D)
            // 修复：使用 renderBounds 而不是 path.boundingRect
            let strokeCenter = lastStroke.renderBounds.center
            
            // 2. 尝试转换 (Raycast)
            spawnObject(at: strokeCenter)
            
            // 3. 清空画布 (制造“变成”了 3D 物体的视觉假象)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                canvasView.drawing = PKDrawing()
            }
        }
        
        func spawnObject(at point: CGPoint) {
            guard let arView = parent.appState.arView else { return }
            
            // 核心魔法：从屏幕 2D 点发射射线，寻找现实世界的水平面
            let results = arView.raycast(from: point, allowing: .estimatedPlane, alignment: .horizontal)
            
            if let result = results.first {
                // 找到了平面！
                
                // 1. 创建锚点 (Anchor)
                let anchor = AnchorEntity(world: result.worldTransform)
                
                // 2. 创建实体 (Entity) - 这里用一个简单的随机色立方体代替复杂的 TaleCraft 模型
                let mesh = MeshResource.generateBox(size: 0.1) // 10cm 的盒子
                let material = SimpleMaterial(color: randomColor(), isMetallic: true)
                let model = ModelEntity(mesh: mesh, materials: [material])
                
                // 添加落地动画 (从高处落下)
                model.position.y = 0.2
                let animationDefinition = FromToByAnimation(
                    name: "drop",
                    from: model.transform,
                    to: Transform(scale: .one, rotation: .init(), translation: .zero), // 归零意味着落到锚点位置
                    duration: 0.5,
                    timing: .easeOut,
                    bindTarget: .transform
                )
                if let animationResource = try? AnimationResource.generate(with: animationDefinition) {
                    model.playAnimation(animationResource)
                }

                // 3. 组装
                anchor.addChild(model)
                arView.scene.addAnchor(anchor)
                
                parent.appState.message = "魔法生效！生成坐标: \(Int(point.x)), \(Int(point.y))"
            } else {
                parent.appState.message = "⚠️ 未检测到平面，请对准地面绘画"
            }
        }
        
        func randomColor() -> UIColor {
            let colors: [UIColor] = [.red, .blue, .green, .purple, .orange, .cyan]
            return colors.randomElement() ?? .white
        }
    }
}

// Helper extension
extension CGRect {
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}
