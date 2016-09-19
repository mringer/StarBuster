//
//  EnemyWeapon.swift
//  StarBuster
//
//  Created by Matthew Ringer on 9/2/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

protocol EnemyWeaponBehaviors {
    var texture:SKTexture?   {get}
    var color:SKColor       {get}
    var size:CGSize         {get}
    
    func spawn(_ weapon:EnemyWeapon, enemy:Enemy, controller:EnemyWeaponController)
    func update(_ weapon:EnemyWeapon, delta: TimeInterval)
    func destroy(_ weapon:EnemyWeapon)
}

class DefaultEnemyWeaponBehaviors:EnemyWeaponBehaviors {
    init(){}
    var texture:SKTexture?   = SKTexture()
    var color:SKColor       = SKColor()
    var size:CGSize         = CGSize()
    
    // TODO: - throw runtime or make nilable
    func spawn(_ weapon:EnemyWeapon, enemy:Enemy, controller:EnemyWeaponController){}
    func update(_ weapon:EnemyWeapon, delta: TimeInterval){}
    func destroy(_ weapon:EnemyWeapon){}
}

class EnemyWeapon:SKSpriteNode {
    
    // MARK: - Public class variables
    internal var drift = CGFloat()
    internal var behaviors:EnemyWeaponBehaviors = DefaultEnemyWeaponBehaviors()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(behaviors: EnemyWeaponBehaviors) {
        
        //var size = CGSize(width: 1.0, height: 5.0)
        if let texture = behaviors.texture as SKTexture? {
            self.init(texture: texture, color: SKColor.red, size: texture.size())
        } else {
            self.init(texture: nil, color: behaviors.color, size: behaviors.size)
        }
        
        self.behaviors = behaviors
        self.setupWeaponPhysics()
    }
    
    // MARK: - Setup
    fileprivate func setupWeaponPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2, center: self.anchorPoint)
        self.physicsBody?.categoryBitMask = Contact.EnemyWeapon // sets the type of sprite in AB collision coparrison
        self.physicsBody?.collisionBitMask = 0x0 // sets collisions with the edge of the screen.
        self.physicsBody?.contactTestBitMask = Contact.Player // determines whitch other sprites trigger collision events
    }
    
    // MARK: - Update
    func update(delta: TimeInterval) {
        self.behaviors.update(self, delta: delta)
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
    override func copy(with zone: NSZone?) -> Any {
        let copy = EnemyWeapon(behaviors: self.behaviors)
        return copy
    }
}
