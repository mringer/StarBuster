//
//  EnemyLaser.swift
//  StarBuster
//
//  Created by Matthew Ringer on 9/2/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class EnemyLaser: EnemyWeapon {
    
    fileprivate var laserCount = 1
    
    convenience init() {
        self.init(texture: nil, color: SKColor.green, size: CGSize(width: 2.0,height: 5.0))
        self.setupWeaponPhysics()
    }
    
    override func spawn(position: CGPoint, controller:EnemyController) {
        for i in 1...laserCount {

            if position.x < (kViewSize.width) || position.x > 0 {
                if let laser = self.copy() as? EnemyLaser {
                    // Copy from array
                    let laserSpacing = laser.size.width * 10
                    // Center the lasers on even numbers
                    let modOffset = CGFloat( (laserCount + 1) % 2 ) * laserSpacing / 2
                    let laserXOffset = laserSpacing * CGFloat(laserCount / 2) - modOffset
                    laser.position = CGPoint(x: position.x + laserSpacing * CGFloat(i) - laserXOffset, y: position.y + laser.size.height)
                    controller.addChild(laser)
                    
                    // Start Movement updates
                    laser.run( SKAction.repeatForever(
                        SKAction.sequence([ SKAction.wait(forDuration: laser.refreshRate),
                                            SKAction.run({ laser.update(delta: laser.refreshRate) })]
                    )))
                }
            }
        }
    }
    
    override func update(delta: TimeInterval) {
        // Move verticallhy up the screen based on device type
        self.position.y =  kDeviceTablet ? self.position.y - CGFloat(delta * 60 *  4) : self.position.y - CGFloat(delta * 60 *  2)
        
        if self.position.y < (0 - self.size.height) {
            self.removeFromParent()
        }
    }
    
}
