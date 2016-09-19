//
//  Bonus.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/14/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

protocol BonusBehaviors {
    var texture:SKTexture   {get}
    
    func bonusPickedUpBy(_ player:Player, statusBar:StatusBar)
}

class DefaultBonusBehaviors:BonusBehaviors {
    init(){
    }
    var texture:SKTexture   = SKTexture()
    func bonusPickedUpBy(_ player:Player, statusBar:StatusBar){}
}

class Bonus:SKSpriteNode {
    
    // MARK: - Public class properties
    internal var drift = CGFloat()
    
    fileprivate var behaviors:BonusBehaviors = DefaultBonusBehaviors()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate override init(texture: SKTexture?, color:UIColor, size:CGSize) {
        super.init(texture: texture, color:color, size:size)
    }
    
    convenience init(behaviors: BonusBehaviors) {
        self.init(texture: behaviors.texture, color: SKColor.white, size: behaviors.texture.size())
        self.setupBonusPhysics()
        self.behaviors = behaviors
    }
    
    fileprivate func setupBonusPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2, center: self.anchorPoint)
        self.physicsBody?.categoryBitMask = Contact.Bonus
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = 0x0
    }
    
    // MARK: - Update
    
    func update(delta:TimeInterval) {
        self.position.x = self.position.x + drift // TODO: - drift is used?
        self.position.y = kDeviceTablet ? self.position.y - CGFloat(delta * 60 * 4) : self.position.y - CGFloat(delta * 60 * 2)
        
        
        // Remove from parent if off the side of the screen
        if self.position.x < (self.size.width) || self.position.x > (kViewSize.width + self.size.width) {
            self.removeFromParent()
        }
        
        // Remove from parent if off the bottom of the screen
        if self.position.y < ( 0 - self.size.height) {
            self.removeFromParent()
        }
        
        // Rotate slowly while moving down screen
        self.zRotation = self.zRotation + CGFloat(delta)
    }
    
    // MARK: - Action
    func pickedUpBy(_ player:Player, statusBar:StatusBar) {
        self.behaviors.bonusPickedUpBy(player, statusBar: statusBar)
        self.playSoundEffect(GameAudio.SoundEffect.Pickup)
        self.removeFromParent()
    }
    
    func gameOver() {
        
    }
    
    // Help NSCopying do its job
    override func copy(with zone: NSZone?) -> Any {
        let copy = Bonus(behaviors: self.behaviors)
        return copy
    }
}
