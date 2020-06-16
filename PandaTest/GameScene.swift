//
//  GameScene.swift
//  PandaTest
//
//  Created by Kishore Narang on 2020-06-16.
//  Copyright © 2020 Kishore Narang. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    //:= Did Move Function Override
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "bakground")
        background.anchorPoint = .zero
        background.zPosition = -1
        addChild(background)
        
    }
}
