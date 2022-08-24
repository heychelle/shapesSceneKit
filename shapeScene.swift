//
//  shapeScene.swift
//  shapesSceneKit
//
//  Created by Michelle Alexandra on 24/08/22.
//

import Foundation
import SwiftUI
import SceneKit

class BoxNode: SCNNode {
    
    override init() {
        let length: CGFloat = 5
        let box = SCNBox(width: length, height: length, length: length, chamferRadius: 0)
        
//      Create the layer
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
        layer.borderColor = UIColor.blue.cgColor
        layer.borderWidth = 100

        // Create a material from the layer and assign it
        box.materials = [UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red].map {
            let material = SCNMaterial()
            material.diffuse.contents = $0
            material.isDoubleSided = true
            material.transparencyMode = .aOne
            return material
        }
        
        super.init()
        
        self.geometry = box
        self.name = "boxNode"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

func createAmbientLighting() -> SCNNode{

    // create and add an ambient light to the scene
    let ambientLightNode = SCNNode()
    ambientLightNode.light = SCNLight()
    ambientLightNode.light!.type = .ambient
    ambientLightNode.light!.color = UIColor.lightGray
    ambientLightNode.light!.intensity = 1500
    return ambientLightNode
}

func createOmniLighting() -> SCNNode{
    
//      create and add a light to the scene
    let lightNode = SCNNode()
    lightNode.light = SCNLight()
    lightNode.light!.type = .omni
    lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
    return lightNode
}

class GameScene: SCNScene {
    
    override init() {
        super.init()
        
        let cubeNode = BoxNode()
        cubeNode.name = "MainActor"
        self.rootNode.addChildNode(cubeNode)
        
        let ambientNode = createAmbientLighting()
        self.rootNode.addChildNode(ambientNode)
        
        let OmniNode = createOmniLighting()
        self.rootNode.addChildNode(OmniNode)
        
        let xAngle = SCNMatrix4MakeRotation(.pi / 3.8, 1, 0, 0)
        let zAngle = SCNMatrix4MakeRotation(-.pi / 4, 0, 0, 1)
        cubeNode.pivot = SCNMatrix4Mult(SCNMatrix4Mult(xAngle, zAngle), cubeNode.transform)
        
        // Rotate the cube
        let animation = CAKeyframeAnimation(keyPath: "rotation")
        animation.values = [SCNVector4(1, 1, 0.3, 0 * .pi),
                            SCNVector4(1, 1, 0.3, 1 * .pi),
                            SCNVector4(1, 1, 0.3, 2 * .pi)]
        animation.duration = 5
        animation.repeatCount = HUGE
        cubeNode.addAnimation(animation, forKey: "rotation")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


