//
//  GameScene.swift
//  PingPong
//
//  Created by Sushila Gadal on 5/3/20.
//  Copyright © 2020 Sushila Gadal. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
   var ball = SKSpriteNode()
   var enemy = SKSpriteNode()
   var main = SKSpriteNode()
    
   var score = [Int]()
    
   var topLbl = SKLabelNode()
   var btmLbl = SKLabelNode()
    
    
    override func didMove(to view: SKView) {
       
        
        topLbl = self.childNode(withName: "topLabel") as! SKLabelNode
        btmLbl = self.childNode(withName: "btmLabel") as! SKLabelNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        print(self.view?.bounds.height)
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 120
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 70
       
       // ball.physicsBody?.applyImpulse(CGVector (dx: 10, dy: 10))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
         startGame()

        
        }
    
    func startGame(){
         score = [0,0]
          topLbl.text = "\(score[1])"
          btmLbl.text = "\(score[0])"
          ball.physicsBody?.applyImpulse(CGVector (dx: 10, dy: 10))
        
        
    }
    
    func addScore(playerWhoWon : SKSpriteNode){
        ball.position = CGPoint(x: 0, y: 0)
       // ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main{
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector (dx: 10, dy: 10))
        }
        else if playerWhoWon == enemy{
           score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector (dx: -10, dy: -10))
        }
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     ball.physicsBody?.applyImpulse(CGVector (dx: 10, dy: 10))
        
        
        for touch in touches{
            let location = touch.location(in:self)
              // I added here
           
            if currentGameType == .player2{
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.01))
                }
                 else if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.01))
                }
                
            }
                
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.01))
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
      //ball.physicsBody?.applyImpulse(CGVector (dx: 10, dy: 10))
        
        for touch in touches{
            let location = touch.location(in:self)
            if currentGameType == .player2{
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                else if location.y < 0 {
                  main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                
            }
            
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        ball.physicsBody?.applyImpulse(CGVector (dx: 0.5, dy: 0.5))
        
        
        switch currentGameType{
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.5))
            break
            
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
            break
            
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            break
            
        case .player2:
            
            break
            
        }
       
        
        if ball.position.y <= main.position.y - 30{
            addScore(playerWhoWon: enemy)
            
        }
        else if ball.position.y >= enemy.position.y + 30 {
            addScore(playerWhoWon: main)
        }
        
    }
}
