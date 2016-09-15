//
//  DiveBomber.swift
//  StarBuster
//
//  Created by Matthew Ringer on 9/8/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class DiveBomber: EnemyBehaviors {
    
    var texture:SKTexture
    var value:Int
    var hitPoints:Int
    var weapons = [EnemyWeapon]()
    
    private var startX:CGFloat
    private var velocity = kDeviceTablet ? CGFloat(4) : CGFloat(2)
    private var lastChange:NSTimeInterval = 0
    
    init() {
        self.texture = GameTextures.sharedInstance.textureWithName( name: SpriteName.EnemyDiveBomber )
        self.value = 1500  // set the value for destroying the enemy
        self.hitPoints = 20     // set the number of hits required to destroy the enemy
        self.startX = kViewSize.width / 2
    }
    
    func spawn(enemy:Enemy, parent:EnemyController){
        let enemyCopy = enemy.copy() as! SKSpriteNode
        
        // X Axis
        self.startX = RandomFloatRange(min: 0, max: kViewSize.width)
        // Y Axis
        let startY = kViewSize.height + enemy.size.height
        // Copy from array
        enemyCopy.position = CGPoint(x: startX, y: startY)
        parent.addChild(enemyCopy)
    }
    
    func update(enemy:Enemy, delta: NSTimeInterval){
        lastChange += delta
        let maxDrift = kViewSize.width / 4
        
        if lastChange > 1 {
            if  enemy.position.x > self.startX + maxDrift {
                velocity = fabs(velocity) * -1
            } else if enemy.position.x < self.startX - maxDrift {
                velocity = fabs(velocity)
            }
            lastChange = 0
        }
        
        enemy.position.x = enemy.position.x + velocity /// CGFloat(delta)
        
        //print("current x: "+String(enemy.position.x)+" start x: "+String(self.startX)+" dif: "+String(difference)+" maxDrift: "+String(maxDrift)+" velocity: "+String(velocity))
        
        enemy.position.x = enemy.position.x + velocity
        
        // Add the drift to position y
        enemy.position.y = kDeviceTablet ? enemy.position.y - CGFloat(delta * 60 *  2) : enemy.position.y - CGFloat(delta * 60 *  1)
        
        if enemy.position.y < (0 - enemy.size.height) {
            enemy.removeFromParent()
        }
        
//        if enemy.position.x < (0 - enemy.size.width) || enemy.position.x > (kViewSize.width + enemy.size.width) {
//            enemy.removeFromParent()
//        }
        
    }
    
    func destroy(enemy:Enemy){
        
    }
    
    func new() -> EnemyBehaviors {
        return DiveBomber()
    }
    
}

