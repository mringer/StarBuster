//
//  CruiserFromRight.swift
//  StarBuster
//
//  Created by Matthew Ringer on 9/1/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class CruiserFromRight: EnemyBehaviors {
    
    var texture:SKTexture
    var value:Int
    var hitPoints:Int
    var weapons = [EnemyWeapon(behaviors: EnemyLaser())]

    
    init() {
        self.texture = GameTextures.sharedInstance.textureWithName( name: SpriteName.EnemyCruiser )
        self.value = 1000  // set the value for destroying the enemy
        self.hitPoints = 5     // set the number of hits required to destroy the enemy
    }
    
    func spawn(enemy:Enemy, parent:EnemyController){
        let enemyCopy = enemy.copy() as! SKSpriteNode
        // X Axis
        let startX = kViewSize.width + enemy.size.width // off stage left
        // Y Axis
        let startY = RandomFloatRange(min: kViewSize.height / 2, max: kViewSize.height  - enemy.size.height / 2)
        // Copy from array
        enemyCopy.position = CGPoint(x: startX, y: startY)
        parent.addChild(enemyCopy)
    }
    
    func update(enemy:Enemy, delta: NSTimeInterval){
        // Move from right to left based on device type.
        enemy.position.x =  kDeviceTablet ? enemy.position.x - CGFloat(delta * 60 *  2) : enemy.position.x - CGFloat(delta * 60 *  1)
        // Add the drift to position y
        enemy.position.y = enemy.position.y
        
        if enemy.position.y < (0 - enemy.size.height) {
            enemy.removeFromParent()
        }
        
        if enemy.position.x < (0 - enemy.size.width) || enemy.position.x > (kViewSize.width + enemy.size.width) {
            enemy.removeFromParent()
        }
        
    }
    
    func destroy(enemy:Enemy){
        
    }
    
    func new() -> EnemyBehaviors {
        return CruiserFromRight()
    }
    
}
