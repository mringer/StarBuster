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
    private let touchOffset:CGFloat = kDeviceTablet ? 64.0 : 32.0
    private let filter:CGFloat = 0.05
    
    // MARK: - Private variables
    private var targetPosition = CGPoint()
    private var canMove = false
    
    
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
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
    
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.Player)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        self.setupPlayer()
        self.setupPlayerPhysics()
    }
    
    // MARK: - Setup Player
    private func setupPlayer() {
    
        // Initial position is centered horozontaly and 20% up the Y-axis
        self.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.20)
        self.targetPosition = self.position
        
        let laser = Weapon(type: Weapon.WeaponType.Laser)
        self.weapons = [laser]
    }
    
    private func setupPlayerPhysics() {
        
        if let texture = self.texture as SKTexture? {
            self.physicsBody = SKPhysicsBody(texture: texture, size: self.size)
            self.physicsBody?.allowsRotation = false
            self.physicsBody?.categoryBitMask = Contact.Player
            self.physicsBody?.collisionBitMask = Contact.Scene
            self.physicsBody?.contactTestBitMask = Contact.Meteor | Contact.Bonus | Contact.Enemy
            }
    }
    
    private func move() {
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
    func updateTargetLocation(newLocation newLocation: CGPoint) {
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
    func updatePlayerScore(score score:Int) {
        self.score += score
    }
    
    // MARK: - Update Player Lives
    private func updatePlayerLives() {
        self.lives -= 1
    }
    
    // MARK: - Action Blink Player
    private func blinkPlayer() {
        let blink = SKAction.sequence([SKAction.fadeOutWithDuration(0.15),SKAction.fadeInWithDuration(0.15)])
        self.runAction(SKAction.repeatActionForever(blink), withKey: "Blink")
    }
    
    // MARK: - Hit Meteor
    func hitMeteor() {
        // Does player have any lives left?
        if self.lives > 0 {
            //Subtract lives
            self.updatePlayerLives()
            // Set Player back to a single laser
            self.weapons = [Weapon(type: Weapon.WeaponType.Laser)]
            
            // Make player immune
            self.immune = true
            
            // Blink player
            self.blinkPlayer()
            // In 3 second remove action key for blink
            self.runAction(SKAction.waitForDuration(3.0), completion: {
                self.immune = false
                self.removeActionForKey("Blink")
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
    }
    
    // MARK: - Pickup 
    func checkStreak(streak streak:Int) {
        if streak > self.highStreak {
            self.highStreak = streak
        }
    }
}
