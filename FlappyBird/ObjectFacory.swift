//
//  ObjectFacory.swift
//  FlappyBird
//
//  Created by Huiping Guo on 2019/12/12.
//  Copyright © 2019 Huiping Guo. All rights reserved.
//

import Foundation
import SpriteKit

struct CollisionBitMask {
    static let bird :UInt32 = 0x1 << 0
    static let pillar :UInt32 = 0x1 << 1
    static let flower :UInt32 = 0x1 << 2
    static let ground :UInt32 = 0x1 << 3
}

struct ObjectFactory {
    func createBird(point: CGPoint) -> SKSpriteNode {
        let bird = SKSpriteNode(texture: SKTextureAtlas(named:"player").textureNamed("bird1"))
        bird.name = "bird"
        bird.size = CGSize(width: 50, height: 50)
        bird.position = point
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.width / 2)
        bird.physicsBody?.linearDamping = 1.1
        bird.physicsBody?.restitution = 0
        bird.physicsBody?.categoryBitMask = CollisionBitMask.bird
        bird.physicsBody?.collisionBitMask = CollisionBitMask.pillar | CollisionBitMask.ground
        bird.physicsBody?.contactTestBitMask = CollisionBitMask.pillar | CollisionBitMask.flower | CollisionBitMask.ground
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        
        return bird
    }
    
    
    func createFlower(point: CGPoint) -> SKNode  {
        let flowerNode = SKSpriteNode(imageNamed: "flower")
        flowerNode.size = CGSize(width: 40, height: 40)
        flowerNode.position = point
        flowerNode.physicsBody = SKPhysicsBody(rectangleOf: flowerNode.size)
        flowerNode.physicsBody?.affectedByGravity = false
        flowerNode.physicsBody?.isDynamic = false
        flowerNode.physicsBody?.categoryBitMask = CollisionBitMask.flower
        flowerNode.physicsBody?.collisionBitMask = 0
        flowerNode.physicsBody?.contactTestBitMask = CollisionBitMask.bird
        flowerNode.color = SKColor.blue
        
        
        return flowerNode
    }
}
