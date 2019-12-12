//
//  GameViewController.swift
//  FlappyBird
//
//  Created by Huiping Guo on 2019/12/12.
//  Copyright © 2019 Huiping Guo. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let view = self.view as? SKView else  { return }
        
        view.ignoresSiblingOrder = false
        view.showsFPS = false
        view.showsNodeCount = false
        
        let scene = SKScene(size: view.bounds.size)
        
        // Load the SKScene from 'GameScene.sks'
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        // Present the scene
        view.presentScene(scene)
        
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
