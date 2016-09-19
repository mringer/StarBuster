//
//  MeteorController.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/8/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class MeteorController:SKNode {
    
    fileprivate let meteor0 = Meteor(type: Meteor.MeteorType.huge)
    fileprivate let meteor1 = Meteor(type: Meteor.MeteorType.large)
    fileprivate let meteor2 = Meteor(type: Meteor.MeteorType.medium)
    fileprivate let meteor3 = Meteor(type: Meteor.MeteorType.small)
    
    // MARK: - Private class variables
    fileprivate var sendingMeteors = false
    fileprivate var movingMeteors = false
    fileprivate var frameCount = 0.0
    fileprivate var meteorArray = [SKSpriteNode]()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(){
        super.init()
        self.setupMeteorController()
    }
    
    fileprivate func setupMeteorController() {
        self.meteorArray = [self.meteor0, self.meteor1, self.meteor2, self.meteor3]
    }
    
    // MARK: - Update
    func update(delta: TimeInterval) {
        // Is it time to send more meteors?
        if self.sendingMeteors {
            self.frameCount += delta
            
            if self.frameCount >= 3.0 {
                // Approximatly 3 seconds have passed, spawn more
                self.spawnMeteors()
                self.frameCount = 0.0
            }
        }
        
        //Move the meteors on screen
        if self.movingMeteors {
            for node in self.children {
                if let meteor = node as? Meteor {
                    meteor.update(delta: delta)
                }
            }
        }
    }
    
    //MARK: - Spawn
    fileprivate func spawnMeteors() {
        if self.sendingMeteors {
            
            let randomMeteorCount = kDeviceTablet ? RandomIntegerBetween(min: 6, max: 10) : RandomIntegerBetween(min: 10, max: 14)
            
            for _ in 0...randomMeteorCount {
                let randomMetorIndex  = RandomIntegerBetween(min: 0, max: self.meteorArray.count - 1)
                // X Axis
                let offsetX:CGFloat = randomMetorIndex % 2 == 0 ? -72 : 72
                let startX = RandomFloatRange(min: 0, max: kViewSize.width) + offsetX
                // Y Axis
                let offsetY:CGFloat = randomMetorIndex % 2 == 0 ? 72 : -72
                let startY = kViewSize.height * 1.25 + offsetY
                // Copy from array
                let meteor = self.meteorArray[randomMetorIndex].copy() as! Meteor
                //Set meteor drift
                meteor.drift = RandomFloatRange(min: -0.5, max: 0.5)
                meteor.position = CGPoint(x: startX, y: startY)
                self.addChild(meteor)
            }
        }
    }
    
    // MARK: - Action function
    func setMeteorsOn(_ on:Bool) {
        self.sendingMeteors = on
        self.movingMeteors = on
    }
    
    fileprivate func gameOver() {
        for node in self.children {
            if let meteor = node as? Meteor {
                meteor.gameOver()
            }
        }
    }
}
