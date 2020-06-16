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
    
    
    
    //:= Variables and constants =
    
    let panda = SKSpriteNode(imageNamed: "panda_01_idle_01")
    let playableRect:CGRect
    let maxMovePerSecond = 7
    var dt:TimeInterval = 0
    var lastUpdateTime:TimeInterval = 0
    
    //Initializer.
    
    override init(size: CGSize) {
        let maxAspectRatio : CGFloat = 16.0/9.0
        let playableHeight = size.height / maxAspectRatio
        let playableMargin = (size.height - playableHeight) / 2.0
        
        playableRect = CGRect(x:0.0,
                              y:playableMargin,
                              width: size.width,
                              height: playableHeight)
        
        super.init(size:size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init not found")
    }
    
    //:= Did Move Function Override
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "bakground")
        background.anchorPoint = .zero
        background.zPosition = -1
        addChild(background)
        //debugDrawPlayableArea()
        
        panda.position = CGPoint(x:100,
                                 y:150)
        panda.setScale(3.0)
        addChild(panda)
        
    }
    
   //:= Override Update Function.
    
    override func update(_ currentTime: TimeInterval) {
        
           if(lastUpdateTime>0)
           {
                dt = currentTime - lastUpdateTime
            }
        lastUpdateTime = currentTime
    }
    
    
    func move(sprite:SKSpriteNode, velocity:CGPoint)
    {
        run(SKAction.repeatForever(SKAction.run(){
            sprite.position.x += CGFloat(400)
        }))
    }
    
    
    
    func debugDrawPlayableArea() {
           let shape = SKShapeNode()
           let path = CGMutablePath()
           path.addRect(playableRect)
           shape.path = path
           shape.strokeColor = SKColor.red
           shape.lineWidth = 4.0
           addChild(shape)
          }

    
    
    
}
