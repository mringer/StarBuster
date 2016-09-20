//
//  Player.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/8/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class Player:SKSpriteNode {
    
    // MARK: - Private class constants
    fileprivate let touchOffset:CGFloat = kDeviceTablet ? 64.0 : 32.0
    fileprivate let filter:CGFloat = 0.05
    
    // MARK: - Private variables
    fileprivate var targetPosition = CGPoint()
    fileprivate var canMove = false
    
    
    // MARK: Public variables
    internal var score:Int = 0
    internal var lives:Int = 3
    internal var immune = false
    internal var starsCollected:Int = 0
    internal var highStreak:Int = 0
    internal var weapons = [Weapon]()
    internal var streakCount:Int = 0
    
    //MARK: - Init
    required init?( coder aDecoder: NSCoder ) {
        super.init(coder: aDecoder)
    }
    
    fileprivate override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
    
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.Player)
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        self.setupPlayer()
        self.setupPlayerPhysics()
    }
    
    // MARK: - Setup Player
    fileprivate func setupPlayer() {
    
        // Initial position is centered horozontaly and 20% up the Y-axis
        self.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.20)
        self.targetPosition = self.position
        
        let laser = Weapon(type: Weapon.WeaponType.laser)
        self.weapons = [laser]
    }
    
    fileprivate func setupPlayerPhysics() {
        
        if let texture = self.texture as SKTexture? {
            self.physicsBody = SKPhysicsBody(texture: texture, size: self.size)
            self.physicsBody?.allowsRotation = false
            self.physicsBody?.categoryBitMask = Contact.Player
            self.physicsBody?.collisionBitMask = Contact.Scene
            self.physicsBody?.contactTestBitMask = Contact.Meteor | Contact.Bonus | Contact.Enemy
            }
        self.zPosition = GameLayer.Player
    }
    
    fileprivate func move() {
        // Set the self position to the target position
        let newX = Smooth(startPoint: self.position.x, endPoint: self.targetPosition.x, filter: filter)
        let newY = Smooth(startPoint: self.position.y, endPoint: self.targetPosition.y, filter: filter)
        self.position = CGPoint(x: newX, y: newY)
        
    }
    
    // MARK: - Update
    func update() {
        if self.canMove {
            self.move()
        }
    }
    
    // MARK: - Movement
    func updateTargetLocation(newLocation: CGPoint) {
        //Set the target location to the new location with the Y position adjusted by touchOffset
        self.targetPosition = CGPoint(x: newLocation.x, y: newLocation.y + self.touchOffset)
        
        // Draw the touch circle
        let touchCircle = TouchCircle()
        self.parent?.addChild(touchCircle)
        touchCircle.animateTouchCircle(atPosition: self.targetPosition)
    }
    
    // Enable / Disable player movement
    func enableMovement() {
        self.canMove = true
    }
    
    func disableMovement() {
        self.canMove = false
    }
    
    // MARK: - Update Player Score
    func updatePlayerScore(score:Int) {
        self.score += score
    }
    
    // MARK: - Update Player Lives
    fileprivate func updatePlayerLives() {
        self.lives -= 1
    }
    
    // MARK: - Action Blink Player
    fileprivate func blinkPlayer() {
        let blink = SKAction.sequence([SKAction.fadeOut(withDuration: 0.15),SKAction.fadeIn(withDuration: 0.15)])
        self.run(SKAction.repeatForever(blink), withKey: "Blink")
    }
    
    // MARK: - Hit Meteor
    func hitMeteor() {
        // Does player have any lives left?
        if self.lives > 0 {
            //Subtract lives
            self.updatePlayerLives()
            // Set Player back to a single laser
            self.weapons = [Weapon(type: Weapon.WeaponType.laser)]
            
            // Make player immune
            self.immune = true
            
            // Blink player
            self.blinkPlayer()
            self.playSoundEffect(GameAudio.SoundEffect.ShieldUp)
            // In 3 second remove action key for blink
            self.run(SKAction.wait(forDuration: 3.0), completion: {
                self.immune = false
                self.removeAction(forKey: "Blink")
                self.playSoundEffect(GameAudio.SoundEffect.ShieldDown)
            })
        }
    }
    
    // MARK: - Game Over
    func gameOver() {
        if self.score > GameSettings.sharedInstance.getBestScore() {
            GameSettings.sharedInstance.saveBestScore(score: self.score)
        }
        
        if self.starsCollected > GameSettings.sharedInstance.getBestStars() {
            GameSettings.sharedInstance.saveBestStars(stars: self.starsCollected)
        }
        
        if self.highStreak > GameSettings.sharedInstance.getBestStreak() {
            GameSettings.sharedInstance.saveBestStreak(streak: self.highStreak)
        }
        
        self.BigBoom(radius: 50, count: 10)
        
        self.removeFromParent()
        
    }
    
    // MARK: - Pickup
    func checkStreak(streak:Int) {
        if streak > self.highStreak {
            self.highStreak = streak
        }
    }
}
