//
//  GameScene.swift
//  ColorGame
//
//  Created by Jasper Tan on 12/23/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var tracksArray: [SKSpriteNode]? = [SKSpriteNode]()
    var player: SKSpriteNode?
    
    func setupTracks() {
        for i in 0...8 {
            if let track = self.childNode(withName: "\(i)") as? SKSpriteNode {
                tracksArray?.append(track)
            }
        }
    }
    
    func createPlayer() {
        player = SKSpriteNode(imageNamed: "player")
        player?.size = CGSize(width: 100, height: 100)
        guard let playerPosition = tracksArray?.first?.position.x else {
            return
        }
        
        player?.position = CGPoint(x: playerPosition, y: self.size.height / 2)
        
        self.addChild(player!)
    }

    override func didMove(to view: SKView) {
        setupTracks()
        createPlayer()
    }
    
    func moveVertically(up: Bool) {

        if up == true {
            let moveAction = SKAction.moveBy(x: 0, y: 5, duration: 0.01)
            let repeatAction = SKAction.repeatForever(moveAction)
            player?.run(repeatAction)
        } else {
            let moveAction = SKAction.moveBy(x: 0, y: -5, duration: 0.01)
            let repeatAction = SKAction.repeatForever(moveAction)
            player?.run(repeatAction)
        }
    
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.previousLocation(in: self)
            let node = self.nodes(at: location).first
            
            if node?.name == "right" || node?.name == "rightimg" {
                print("Move right")
            }
            else if node?.name == "up" || node?.name == "upimg" {
                print("Move up")
                moveVertically(up: true)
            }
            else if node?.name == "down" || node?.name == "downimg" {
                print("Move down")
                moveVertically(up: false)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player?.removeAllActions()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        player?.removeAllActions()
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
