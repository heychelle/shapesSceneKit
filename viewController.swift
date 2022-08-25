//
//  viewController.swift
//  shapesSceneKit
//
//  Created by Michelle Alexandra on 24/08/22.
//

import SwiftUI
import SceneKit

class GameSceneViewController: UIViewController {
    
    private let sceneView: SCNView = .init(frame: .zero)
    private let scene = GameScene()
    
    var sideTapped: ((Int, SCNView) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sceneView)
        
        NSLayoutConstraint.activate([
            sceneView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sceneView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            sceneView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
//        sceneView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: sceneView) else { return }
        guard let hitTestResult = sceneView.hitTest(touchPoint, options: nil).first else { return }
        guard hitTestResult.node is BoxNode else { return }
        
        sideTapped?(hitTestResult.geometryIndex, sceneView)
    }
}

func cameraNode() -> SCNNode {
    let cameraNode = SCNNode()
    cameraNode.camera = SCNCamera()
    cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
    return cameraNode
}

struct GSViewControllerRepresentable: UIViewControllerRepresentable {
    
    let sideTapped: ((Int, SCNView) -> Void)?
    let scene = SCNScene()
    
    func makeUIViewController(context: Context) -> GameSceneViewController {
        
        scene.rootNode.addChildNode(cameraNode())
        
        let vc = GameSceneViewController()
        vc.sideTapped = sideTapped
        return vc
    }
    
    func updateUIViewController(_ uiViewController: GameSceneViewController, context: Context) {
    
    }
}
