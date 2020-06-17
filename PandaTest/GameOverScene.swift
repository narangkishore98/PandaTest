//
//  GameOverScene.swift
//  PandaTest
//
//  Created by Kishore Narang on 2020-06-16.
//  Copyright © 2020 Kishore Narang. All rights reserved.
//

import Foundation
import SpriteKit
class GameOverScene:SKScene
{
    
    let won:Bool
    init(size: CGSize, won: Bool) {
    self.won = won
    super.init(size: size)
    }

    required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        let label = SKLabelNode(fontNamed: "Chalkduster");
        label.fontSize = 100
        label.color = .white
        label.position = CGPoint(x:size.width/2,
                                 y:size.height/2)
        if(won)
        {
            label.text = "YOU WIN"
        }
        else
        {
            label.text = "YOU LOSE"
        }
        addChild(label)
    }
}
