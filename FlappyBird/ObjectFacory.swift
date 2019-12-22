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
    
    func createGoldFlower(point: CGPoint) -> SKNode {
        let a = createFlower(point: point) as! SKSpriteNode
        
        a.color = UIColor.yellow
        a.colorBlendFactor = 1.0
        
        return a
    }
    
    func createFlower(point: CGPoint) -> SKNode  {
        let flowerNode = SKSpriteNode(imageNamed: "flower")
        flowerNode.name = "flower"

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
    
    func createScoreLabel(point: CGPoint) -> SKLabelNode {
        let scoreLbl = SKLabelNode()
        scoreLbl.position = point
        scoreLbl.text = ""
        scoreLbl.zPosition = 5
        scoreLbl.fontSize = 50
        scoreLbl.fontName = "HelveticaNeue-Bold"
        
        let scoreBg = SKShapeNode()
        scoreBg.position = CGPoint(x: 0, y: 0)
        scoreBg.path = CGPath(roundedRect: CGRect(x: CGFloat(-50), y: CGFloat(-30), width: CGFloat(100), height: CGFloat(100)), cornerWidth: 50, cornerHeight: 50, transform: nil)
        let scoreBgColor = UIColor(red: CGFloat(0.0 / 255.0), green: CGFloat(0.0 / 255.0), blue: CGFloat(0.0 / 255.0), alpha: CGFloat(0.2))
        scoreBg.strokeColor = UIColor.clear
        scoreBg.fillColor = scoreBgColor
        scoreBg.zPosition = -1
        scoreLbl.addChild(scoreBg)
        return scoreLbl
    }
    
    
    func createCounterLabel(point: CGPoint) -> SKLabelNode {
        let counterLabel = SKLabelNode()
        counterLabel.position = point
        counterLabel.text = ""
        counterLabel.zPosition = 5
        counterLabel.fontSize = 20
        counterLabel.fontName = "HelveticaNeue-Bold"
        
        return counterLabel
    }
    
    func createRestartBtn(point: CGPoint) -> SKSpriteNode {
        let restartBtn = SKSpriteNode(imageNamed: "restart")
        restartBtn.size = CGSize(width:100, height:100)
        restartBtn.position = point
        restartBtn.zPosition = 6
        restartBtn.setScale(0)
        restartBtn.run(SKAction.scale(to: 1.0, duration: 0.3))
        
        return restartBtn
    }
}
