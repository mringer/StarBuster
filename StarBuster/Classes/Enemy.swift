//
//  EnemyCruiser.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/31/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

protocol EnemyBehaviors {
    var texture:SKTexture           {get}
    var value:Int                   {get}
    var hitPoints:Int               {get}
    var weapons:[EnemyWeapon]       {get}
    //var weapons:EnemyWeaponController {get}
    func spawn(enemy:Enemy, parent:EnemyController)
    func update(enemy:Enemy, delta: NSTimeInterval)
    func destroy(enemy:Enemy)
    
    func new() -> EnemyBehaviors
}

class DefaultEnemyBehaviors:EnemyBehaviors {
    var texture:SKTexture           = SKTexture()
    var value:Int                   = 0
    var hitPoints:Int               = 0
    var weapons:[EnemyWeapon] = [EnemyWeapon]()
    
    init(){
    }
    
    // TODO: - throw runtime or make nilable
    func spawn(enemy:Enemy, parent:EnemyController){}
    func update(enemy:Enemy, delta: NSTimeInterval){}
    func destroy(enemy:Enemy){}
    func new() -> EnemyBehaviors {
        return DefaultEnemyBehaviors()
    }
}

class Enemy:SKSpriteNode {
    
    // MARK: - Enmy implementation
    var value:Int = 0
    var hitPoints:Int = 0
    
    //enemy: Enemy(), weapons:[EnemyWeapon]()) //this may cause the weapons to be removed on destruction....
    
    var behaviors:EnemyBehaviors = DefaultEnemyBehaviors()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.setupEnemyPhysics()
    }
    
    convenience init(behaviors: EnemyBehaviors) {
        // Set the size of the meteor
        let texture = behaviors.texture
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        self.behaviors = behaviors
        self.hitPoints = behaviors.hitPoints
        self.value = behaviors.value
    }
    
    private func setupEnemyPhysics() {
        if let texture = self.texture as SKTexture? {
            self.physicsBody = SKPhysicsBody(texture: texture, size: self.size)
            self.physicsBody?.categoryBitMask = Contact.Enemy
            self.physicsBody?.collisionBitMask = 0x0 // Igore collisions
            self.physicsBody?.contactTestBitMask = 0x0 // Ignore contact
        }
    }
    
    //MARK: - Spawn
    func spawnEnemy(parent: EnemyController) {
        self.behaviors.spawn(self, parent: parent)
    }
    
    // MARK: - Update
    func update(delta delta: NSTimeInterval) {
        self.behaviors.update(self, delta: delta)
    }
    
    func hit(hit:Int, player: Player?) {
        self.hitPoints -= hit
        if self.hitPoints <= 0 {
            // Increase player score by enemy value
            FloatLabel.spawn(self, value: String(self.value))
            // Check and update player score
            if let p = player as Player? {
                p.updatePlayerScore(score: self.value)
            }
            // TODO: - Destruction Animation
            self.behaviors.destroy(self)
            self.removeFromParent()
        }
    }
    
    // executes when the game ends....
    // TODO: - add to behaviors
    func gameOver() {
        
    }
    
    // Help NSCopying do its job
    override func copyWithZone(zone: NSZone) -> AnyObject {
        //var newBehavior =
        let copy = Enemy(behaviors: self.behaviors.new())
        return copy
    }
    
}
