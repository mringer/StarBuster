//
//  EnemyWeapon.swift
//  StarBuster
//
//  Created by Matthew Ringer on 9/2/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class EnemyWeapon:SKSpriteNode  {
    
    
    // MARK: - Public class variables
    var refreshRate:Double = 0.03
    var fireRate:Double = 2.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        self.init(texture: nil, color: SKColor.blue, size: CGSize(width: 5.0,height: 5.0))
        self.setupWeaponPhysics()
    }
    
    // MARK: - Setup
    func setupWeaponPhysics() {
        if (self.texture != nil) {
            self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        } else {
            self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2, center: self.anchorPoint)
        }
        self.physicsBody?.categoryBitMask = Contact.EnemyWeapon // sets the type of sprite in AB collision coparrison
        self.physicsBody?.collisionBitMask = 0x0 // sets collisions with the edge of the screen.
        self.physicsBody?.contactTestBitMask = Contact.Player // determines whitch other sprites trigger collision events
        self.physicsBody?.contactTestBitMask = Contact.Player | Contact.Weapon
    }
    
    // MARK: - Update
    func spawn(position:CGPoint, controller:EnemyController) {
        let laserCount = 3
        for i in 1...laserCount {
            if position.x < (kViewSize.width) || position.x > 0 {
                if let laser = self.copy() as? EnemyWeapon {
                    // Copy from array
                    let laserSpacing = laser.size.width * 10
                    // Center the lasers on even numbers
                    let modOffset = CGFloat( (laserCount + 1) % 2 ) * laserSpacing / 2
                    let laserXOffset = laserSpacing * CGFloat(laserCount / 2) - modOffset
                    laser.position = CGPoint(x: position.x + laserSpacing * CGFloat(i) - laserXOffset, y: position.y + laser.size.height)
                    
                    // Start Movement updates
                    laser.run( SKAction.repeatForever(
                        SKAction.sequence([ SKAction.wait(forDuration: laser.refreshRate),
                                            SKAction.run({ laser.update(delta: laser.refreshRate) })]
                    )))
                    
                    controller.addChild(laser)
                }
            }
        }
    }
    
    func update(delta: TimeInterval) {
        // Move verticallhy up the screen based on device type
        self.position.y =  kDeviceTablet ? self.position.y - CGFloat(delta * 80 *  4) : self.position.y - CGFloat(delta * 80 *  2)
        
        if self.position.y < (0 - self.size.height) {
            self.removeFromParent()
        }
    }
    
    func hitWeapon() {
        let explosion = Explosion(position: self.position)
        self.parent?.addChild(explosion)
        explosion.runAndExit()
        self.removeFromParent()
    }
    
    func gameOver() {
        
    }
    
    // Help NSCopying do its job
//    override func copy(with zone: NSZone?) -> Any {
//        let copy = EnemyWeapon()
//        return copy
//    }
}
