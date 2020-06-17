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
    let maxMovePerSecond = 100
    var dt:TimeInterval = 0
    var lastUpdateTime:TimeInterval = 0
    var velocity:CGPoint = .zero
    
    var lives = 3
    
    
    var lastChanged = 0
    
    
    let labelNode = SKLabelNode(fontNamed: "Chalkduster")
    
    
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
        
        velocity = CGPoint(x:maxMovePerSecond, y:0)
        addChild(panda)
        spawnSpikes()
        
        
        labelNode.text = "Lives: \(lives)"
        labelNode.fontColor = .black
        labelNode.fontSize = 100
        labelNode.zPosition = 1300
        labelNode.position = CGPoint(x:300,
                                     y:500)
        addChild(labelNode)
        
      
        
    }
    
   //:= Override Update Function.
    
    override func update(_ currentTime: TimeInterval) {
        
           if(lastUpdateTime>0)
           {
                dt = currentTime - lastUpdateTime
            }
            lastUpdateTime = currentTime
          boundsCheck()
        move(sprite: panda, velocity:velocity )
      collideSpike()
        labelNode.text = "Lives \(lives)"
   
       
      
    }
    
    
    func move(sprite:SKSpriteNode, velocity:CGPoint)
    {
        let amountToMove = CGPoint(x:velocity.x * CGFloat(dt),
                                   y:velocity.y * CGFloat(dt))
        sprite.position += amountToMove
//       // run(SKAction.repeatForever(SKAction.run(){
//         //   sprite.position.x += CGFloat(400)
//        }))
        
        
        
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

    
    
    func boundsCheck()
    {
        let bottomLeft:CGPoint = CGPoint(x:0,
                                         y:playableRect.minY)
        let topRight:CGPoint = CGPoint(x:size.width,
                                       y:playableRect.maxY)
        if panda.position.x >= topRight.x
        {
            velocity.x = -velocity.x
        }
        if panda.position.x <= bottomLeft.x
        {
            velocity.x = -velocity.x
            print("PANDA IS OUT VIA LEFT")
        }
        
    }
    
    
    
    //JUMP
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        jump(panda: panda, velocity: velocity)
        print("TOUCH HAPPENED")
    }
    
    func jump(panda:SKSpriteNode, velocity:CGPoint)
    {
        var xVal:CGFloat = 100.0
        if velocity.x <= 0
        {
            print("Going Right")
            xVal = -xVal
        }
        else
        {
            xVal = CGFloat(abs(xVal))
            print("Going Left")
        }
        
    
        let goUp = SKAction.moveBy(x: xVal, y: 200, duration: 0.5)
        let goDown = SKAction.moveBy(x: xVal, y: -200, duration: 0.5)
        
        let sequence:[SKAction] = [goUp, goDown]
        
        
        
        panda.run(SKAction.sequence(sequence))
        
    }
    
    
    func spawnSpikes()
    {
        let spike = SKSpriteNode(imageNamed: "spikes")
        spike.position = CGPoint(x: CGFloat.random(min: playableRect.minX + 150,
                                                   max:playableRect.maxX - 150),
                                y:130 )
       spike.setScale(2.0)
        spike.name = "spike"
        addChild(spike)
        
    }
    
    
    func collideSpike()
    {
        var spikes:[SKSpriteNode] = []
        enumerateChildNodes(withName: "spike")
        {
            node, _ in
            let spike = node as! SKSpriteNode
            if spike.frame.insetBy(dx: 25, dy: 25).intersects(self.panda.frame)
            {
                //self.lastChanged -= 1
                spikes.append(spike)
                spike.removeFromParent()
                self.lives -= 1
                self.panda.position = CGPoint(x:100,
                                                    y:150)
                self.spawnSpikes()
                
             
            }
            
        }
        for spike in spikes{
            spike.removeFromParent()
        }
   
        //reset()
    }
    
    func reset()
    {
        
             panda.position = CGPoint(x:100,
                                      y:150)
    }
    
    
    
    
    
}
