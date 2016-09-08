//
//  Weapon.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/8/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class Weapon:SKSpriteNode {
    
    // MARK: - Public enum
    internal enum WeaponType {
        case Laser
    }
    
    // MARK: - Public class variables
    internal var drift = CGFloat()
    internal var weaponType = WeaponType.Laser
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(type: WeaponType) {
        
        var size = CGSize()
        
        switch type {
        case WeaponType.Laser:
            // TODO: - replace with a laser sprite
            size = CGSize(width: 2.0, height: 5.0)
            
        }
        
        self.init(texture: nil, color: SKColor.redColor(), size: size)
        self.color = SKColor.redColor()
        self.setupWeapon()
        self.setupWeaponPhysics()
    }
    
    // MARK: - Setup
    private func setupWeapon(){
        
    }
    
    private func setupWeaponPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2, center: self.anchorPoint)
        self.physicsBody?.categoryBitMask = Contact.Weapon // sets the type of sprite in AB collision coparrison
        self.physicsBody?.collisionBitMask = 0x0 // sets collisions with the edge of the screen.
        self.physicsBody?.contactTestBitMask = Contact.Meteor | Contact.Enemy // determines whitch other sprites trigger collision events
    }
    
    // MARK: - Update
    func update(delta delta: NSTimeInterval) {
        
        // Move verticallhy up the screen based on device type
        self.position.y =  kDeviceTablet ? self.position.y + CGFloat(delta * 60 *  6) : self.position.y + CGFloat(delta * 60 *  3)
        
        if self.position.y > (kViewSize.height + self.size.height) {
            self.removeFromParent()
        }
    }
    
    func hitWeapon() {

        let explosion = Explosion()
        explosion.position = self.position
        self.parent?.addChild(explosion)
        explosion.runAndExit()
        
        self.removeFromParent()
    }
    
    func gameOver() {
        
    }
}
