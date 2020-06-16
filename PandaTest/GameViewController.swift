//
//  GameViewController.swift
//  PandaTest
//
//  Created by Kishore Narang on 2020-06-16.
//  Copyright © 2020 Kishore Narang. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: CGSize(width: 1280 , height: 720))
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.ignoresSiblingOrder = true
        skView.showsNodeCount = true
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
       
        }
    

    override var shouldAutorotate: Bool {
        return true
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
