//
//  Meteor.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/8/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

public class Meteor:SKSpriteNode {
    
    // MARK: - Public enum
    public enum MeteorType {
        case Huge
        case Large
        case Medium
        case Small
    }
    
    // MARK: - Public class variables
    var drift = CGFloat()
    var meteorSize = MeteorType.Huge
    var value = 0
    
    private var hitPoints = 1
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(type: MeteorType) {
        // Set the size of the meteor
        let meteorSize = type
        var value = 0
        var texture = SKTexture()
        
        switch type {
        case MeteorType.Huge:
            texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.MeteorHuge)
            value = 10
        case MeteorType.Large:
            texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.MeteorLarge)
            value = 20
        case MeteorType.Medium:
            texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.MeteorMedium)
            value = 40
        case MeteorType.Small:
            texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.MeteorSmall)
            value = 60
        }
        
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        self.meteorSize = meteorSize
        self.value = value
        self.setupMeteor()
        self.setupMeteorPhysics()
    }
    
    // MARK: - Setup
    private func setupMeteor(){
        
    }
    
    private func setupMeteorPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2, center: self.anchorPoint)
        self.physicsBody?.categoryBitMask = Contact.Meteor
        self.physicsBody?.collisionBitMask = 0x0 // Igore collisions
        self.physicsBody?.contactTestBitMask = 0x0 // Ignore contact
    }
    
    // MARK: - Update
    func update(delta delta: NSTimeInterval) {
        
        // Move verticallhy down the screen based on device type
        self.position.y =  kDeviceTablet ? self.position.y - CGFloat(delta * 60 *  4) : self.position.y - CGFloat(delta * 60 *  2)
        // Add the drift to position x
        self.position.x = self.position.x + drift
        
        if self.position.y < (0 - self.size.height) {
            self.removeFromParent()
        }
        
        if self.position.x < (0 - self.size.width) || self.position.x > (kViewSize.width + self.size.width) {
            self.removeFromParent()
        }
    }
    
    func getMeteorSize() -> MeteorType {
        return self.meteorSize
    }
    
    func hit(damage:Int, player:Player?) {
        self.hitPoints -= damage
        if self.hitPoints <= 0 {
            if let p = player as Player? {
                p.updatePlayerScore(score: self.value)
            }
            FloatLabel.spawn(self, value: String(self.value))
            self.removeFromParent()
        }
    }
    
    func gameOver() {
        
    }
    
    // Help NSCopying do its job
    override public func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = Meteor(type: meteorSize)
        return copy
    }
}
