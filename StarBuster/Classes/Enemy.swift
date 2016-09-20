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
    
    func spawn(_ enemy:Enemy ) -> Enemy
    func update(_ enemy:Enemy, delta: TimeInterval)
    func destroy(_ enemy:Enemy)
    
    // Clone behavior for for dereferencing inside NSCopying copyWithZone
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
    func spawn(_ enemy:Enemy ) -> Enemy { return Enemy() }
    func update(_ enemy:Enemy, delta: TimeInterval){}
    func destroy(_ enemy:Enemy){}
    func new() -> EnemyBehaviors {
        return DefaultEnemyBehaviors()
    }
}

class Enemy:SKSpriteNode {
    
    // MARK: - Enmy implementation
    var value:Int = 0
    var hitPoints:Int = 0
    var refreshRate:Double = 0.03
    
    var behaviors:EnemyBehaviors = DefaultEnemyBehaviors()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.zPosition = GameLayer.Enemy
        self.setupEnemyPhysics()
    }
    
    convenience init(behaviors: EnemyBehaviors) {
        // Set the size of the meteor
        let texture = behaviors.texture
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        self.behaviors = behaviors
        self.hitPoints = behaviors.hitPoints
        self.value = behaviors.value
    }
    
    fileprivate func setupEnemyPhysics() {
        if let texture = self.texture as SKTexture? {
            
            self.physicsBody = SKPhysicsBody(texture: texture, size: self.size)
            self.physicsBody?.categoryBitMask = Contact.Enemy
            self.physicsBody?.collisionBitMask = 0x0 // Igore collisions
            self.physicsBody?.contactTestBitMask = Contact.Player | Contact.Weapon
            self.zPosition = GameLayer.Enemy
        }
    }
    
    //MARK: - Spawn
    func spawnEnemy(_ parent: EnemyController) {
        
        let enemy = self.behaviors.spawn(self)
        parent.addChild(enemy)
        // Start Weapons action.... 
        
        // Start Movement updates
        enemy.run( SKAction.repeatForever(
            SKAction.sequence([ SKAction.wait(forDuration: enemy.refreshRate),
                                SKAction.run({ enemy.update(delta: enemy.refreshRate) })]
        )))
        
        // Start Weapons Action
        for weapon in enemy.behaviors.weapons {
            enemy.run( SKAction.repeatForever(
                SKAction.sequence([ SKAction.wait(forDuration: weapon.fireRate),
                                    SKAction.run({ weapon.spawn(position: enemy.position, controller: parent) })]
            )))
        }
        
    }
    
    // MARK: - Update
    func update(delta: TimeInterval) {
        self.behaviors.update(self, delta: delta)
    }
    
    func hit(_ hit:Int, player: Player?) {
        self.hitPoints -= hit
        if self.hitPoints <= 0 {
            
            // Check and update player score
            if let p = player as Player? {
                p.updatePlayerScore(score: self.value)
            }
            // TODO: - Destruction Animation TODO: Refactor
            self.behaviors.destroy(self)
            
            // Display bonus message
            let position = CGPoint(x: self.position.x, y: self.position.y - self.frame.size.height / 2 )
            self.parent?.addChild(FloatLabel.spawn(position, text: String(self.value)))
            
            self.removeFromParent()
        }
    }
    
    // executes when the game ends....
    // TODO: - add to behaviors
    func gameOver() {
        
    }
    
    // Help NSCopying do its job
    override func copy(with zone: NSZone?) -> Any {
        //var newBehavior =
        let copy = Enemy(behaviors: self.behaviors.new())
        return copy
    }
    
}
