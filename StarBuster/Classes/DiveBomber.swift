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
    var weapons:[EnemyWeapon] = [EnemyWeapon()]
    
    fileprivate var startX:CGFloat
    fileprivate var velocity = kDeviceTablet ? CGFloat(4) : CGFloat(2)
    fileprivate var lastChange:TimeInterval = 0
    
    init() {
        //self.texture = GameTextures.sharedInstance.textureWithName( name: SpriteName.EnemyCruiser )
        self.texture = GameTextures.sharedInstance.textureWithName( name: SpriteName.EnemyDiveBomber )
        self.value = 1500  // set the value for destroying the enemy
        self.hitPoints = 10     // set the number of hits required to destroy the enemy
        self.startX = kViewSize.width / 2
    }
    
    func spawn(_ enemy:Enemy) -> Enemy{
        let enemyCopy = enemy.copy() as! SKSpriteNode
        // X Axis
        self.startX = RandomFloatRange(min: 0, max: kViewSize.width)
        // Y Axis
        let startY = kViewSize.height + enemy.size.height
        // Copy from array
        enemyCopy.position = CGPoint(x: startX, y: startY)
        enemyCopy.name = SpriteName.EnemyDiveBomber
        
        return enemyCopy as! Enemy
    }
    
    func update(_ enemy:Enemy, delta: TimeInterval){
        lastChange += delta
        let maxDrift = kViewSize.width / 5
        
        if lastChange > 1 {
            if  enemy.position.x > self.startX + maxDrift {
                velocity = fabs(velocity) * -1
            } else if enemy.position.x < self.startX - maxDrift {
                velocity = fabs(velocity)
            }
            lastChange = 0
        }
        
        enemy.position.x = enemy.position.x + velocity
        
        // Add the drift to position y
        enemy.position.y = kDeviceTablet ? enemy.position.y - CGFloat(delta * 100 *  2) : enemy.position.y - CGFloat(delta * 100 *  1)
        
        if enemy.position.y < (0 - enemy.size.height) {
            enemy.removeFromParent()
        }
    }
    
    func destroy(_ enemy:Enemy){
        
    }
    
    func new() -> EnemyBehaviors {
        return DiveBomber()
    }
    
}

