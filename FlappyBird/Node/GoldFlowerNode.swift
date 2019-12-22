//
//  GoldFlowerNode.swift
//  FlappyBird
//
//  Created by Huiping Guo on 2019/12/22.
//  Copyright © 2019 Huiping Guo. All rights reserved.
//

import Foundation
import SpriteKit

class GoldFlowerNode: FlowerNode {
    init(point: CGPoint) {
           let texture = SKTexture(imageNamed: "gold_flower")
           super.init(texture: texture, color: .blue, size: texture.size())
           
           self.name = "flower"

           self.size = CGSize(width: 40, height: 40)
           self.position = point
           let physicsBody = SKPhysicsBody(rectangleOf: self.size)
           physicsBody.affectedByGravity = false
           physicsBody.isDynamic = false
           physicsBody.categoryBitMask = CollisionBitMask.flower
           physicsBody.collisionBitMask = 0
           physicsBody.contactTestBitMask = CollisionBitMask.bird
           
           self.physicsBody = physicsBody
       }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
