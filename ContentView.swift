//
//  ContentView.swift
//  shapesSceneKit
//
//  Created by Michelle Alexandra on 24/08/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            GSViewControllerRepresentable { side, scene in
                print(side)
                
        //      Create the layer
                let layer = CALayer()
                layer.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
                layer.backgroundColor = UIColor.red.cgColor
                layer.borderColor = UIColor.blue.cgColor
                layer.borderWidth = 100
                
//                scene.scene?.rootNode.childNode(withName: "MainActor", recursively: false)?.geometry?.materials[side].diffuse.contents = UIColor.blue
                scene.scene?.rootNode.enumerateChildNodes { (childNode, stop) in
                    
                    if (childNode.name == "MainActor") {
                        for i in 0...(childNode.geometry?.materials.count)!-1 {
                            if (side == i) {
                                childNode.geometry?.materials[i].diffuse.contents = layer
                            } else {
                                childNode.geometry?.materials[i].diffuse.contents = UIColor.red
                            }
                        }
                    }
                    
                }
                
                // Perform additional logic here
            }
//            .frame(width: 200, height: 200)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
