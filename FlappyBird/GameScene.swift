//
//  GameScene.swift
//  FlappyBird
//
//  Created by Huiping Guo on 2019/12/12.
//  Copyright © 2019 Huiping Guo. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // view object
    var bird = SKSpriteNode()
    let birdAtlas = SKTextureAtlas(named:"player")
    var birdSprites = [SKTexture]()

        
    
    // action
    var repeatActionbird = SKAction()
    
    
    // state
    var gameStarted = false
    var birdIsDied = false
    
    
    var score = 0

    // other
    let objetctFactory = ObjectFactory()


    
    override func didMove(to view: SKView) {
        createScene()
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameStarted {
            gameStarted = true
            startGame()
            return
        }
        
        doBirdFly()
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if gameStarted && !birdIsDied {
            enumerateChildNodes(withName: "background", using: ({
                (node, error) in
                let bg = node as! SKSpriteNode
                bg.position = CGPoint(x: bg.position.x - 2, y: bg.position.y)
                if bg.position.x <= -bg.size.width {
                    bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y:bg.position.y)
                }
            }))
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}

extension GameScene {
    func startGame() {
        bird.physicsBody?.affectedByGravity = true

        self.bird.run(repeatActionbird)

        doBirdFly()
    }
    
    func doBirdFly() {
        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
    }
    
    func restartScene(){
        self.removeAllChildren()
        self.removeAllActions()
        birdIsDied = false
        gameStarted = false
        score = 0
        createScene()
    }
}


extension GameScene {
    func createScene() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = CollisionBitMask.groundCategory
        self.physicsBody?.collisionBitMask = CollisionBitMask.birdCategory
        self.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        
        self.physicsWorld.contactDelegate = self
        self.backgroundColor = SKColor(red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        for i in 0..<2 {
            let background = SKSpriteNode(imageNamed: "bg")
            background.anchorPoint = CGPoint.init(x: 0, y: 0)
            background.position = CGPoint(x:CGFloat(i) * self.frame.width, y:0)
            background.name = "background"
            background.size = (self.view?.bounds.size)!
            self.addChild(background)
        }
        
        //SET UP THE BIRD SPRITES FOR ANIMATION
        birdSprites.append(birdAtlas.textureNamed("bird1"))
        birdSprites.append(birdAtlas.textureNamed("bird2"))
        birdSprites.append(birdAtlas.textureNamed("bird3"))
        birdSprites.append(birdAtlas.textureNamed("bird4"))
        
        self.bird = objetctFactory.createBird(point: CGPoint(x:self.frame.midX, y:self.frame.midY))
        self.addChild(bird)
        
        //ANIMATE THE BIRD AND REPEAT THE ANIMATION FOREVER
        let animatebird = SKAction.animate(with: self.birdSprites, timePerFrame: 0.1)
        self.repeatActionbird = SKAction.repeatForever(animatebird)
    }
}
