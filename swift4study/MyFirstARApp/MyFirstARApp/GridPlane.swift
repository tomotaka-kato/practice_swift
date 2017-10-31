//
//  GridPlane.swift
//  MyFirstARApp
//
//  Created by tomotaka.kato on 2017/10/30.
//  Copyright © 2017 tomotaka.kato. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

class GridPlane: SCNNode {
    var anchor : ARPlaneAnchor
    var planeGeometry: SCNPlane!
    
    init(anchor: ARPlaneAnchor) {
        self.anchor = anchor
        super.init()
        setup()
    }
    
    private func setup() {
        self.planeGeometry = SCNPlane(width: CGFloat(self.anchor.extent.x), height: CGFloat(self.anchor.extent.z))
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "overlay_grid.png")
        
        self.planeGeometry.materials = [material]
        
        let planeNode = SCNNode(geometry: self.planeGeometry)
        planeNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
        planeNode.transform = SCNMatrix4MakeRotation(Float(-Double.pi / 2.0), 1.0, 0.0, 0.0)
        
        self.addChildNode(planeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Fatal Error")
    }
}
