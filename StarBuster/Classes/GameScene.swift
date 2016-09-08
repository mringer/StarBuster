//
//  GameScene.swift
//  StarBuster
//
//  Created by Matthew Ringer on 7/22/16.
//  Copyright (c) 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    //MARK: - Private class contant
    private let gameNode = SKNode()
    private let interfaceNode = SKNode()
    private let background = Background()
    private let startButton = StartButton()
    private let player = Player()
    private let meteorController = MeteorController()
    private let bonusController = BonusController()
    private let weaponController = WeaponController()
    private let enemyWeaponController = EnemyWeaponController()
    
    
    private let enemyController = EnemyController(enemiesArray: [Enemy(behaviors: CruiserFromRight()), Enemy(behaviors: CruiserFromLeft())])
    
    private enum GameState:Int {
        case Tutorial
        case Running
        case Paused
        case GameOver
    }
    
    // Private Variables
    private var state = GameState.Tutorial
    private var lastUpdateTime:NSTimeInterval = 0.0
    private var frameCount:NSTimeInterval = 0.0
    private var statusBar = StatusBar()
    
    //MARK: - Init
    required init?(coder aDecoder: NSCoder ){
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize){
        super.init(size: size)
    }
    
    override func didMoveToView(view: SKView) {
        self.setupGameScene()
    }
    
    //MARK: - Setup
    private func setupGameScene(){
        //Set the background
        self.backgroundColor = SKColor.blackColor()

        self.physicsWorld.gravity = CGVectorMake(0,0)
        self.physicsWorld.contactDelegate = self
        
        //Create Physics body for gameNode
        let screenBounds = CGRectMake(-self.player.size.width / 2, 0, kViewSize.width + self.player.size.width, kViewSize.height)
        gameNode.physicsBody = SKPhysicsBody(edgeLoopFromRect: screenBounds)
        
        // Create boundary using ScreenBounds
        self.gameNode.physicsBody?.categoryBitMask = Contact.Scene
        
        // Setup StatusBar
        self.statusBar = StatusBar(lives: self.player.lives, score: self.player.score, stars: self.player.starsCollected)
        self.interfaceNode.addChild(self.statusBar)
        
        // Add GameNode to scene 
        self.addChild(self.gameNode)
        
        // Add child nodes to gameNode
        self.gameNode.addChild(self.background)
        self.gameNode.addChild(self.startButton)
        self.gameNode.addChild(self.player)
        self.gameNode.addChild(self.meteorController)
        self.gameNode.addChild(self.bonusController)
        self.gameNode.addChild(self.weaponController)
        self.gameNode.addChild(self.enemyController)
        self.gameNode.addChild(self.enemyWeaponController)
        
        // Add interfaceNode to scene
        self.addChild(self.interfaceNode)
        
    }
    
    //MARK: - Update
    override func update(currentTime: NSTimeInterval){
        // Calculate delta
        let delta = currentTime - self.lastUpdateTime
        self.lastUpdateTime = currentTime
        
        switch self.state {
            case GameState.Tutorial:
                return
        
            case GameState.Running:
                if self.player.lives > 0 {
                    self.player.update()
                    self.meteorController.update(delta: delta)
                    self.bonusController.update(delta: delta)
                    self.weaponController.update(delta: delta, player: self.player)
                    self.enemyController.update(delta: delta)
                    self.enemyWeaponController.update(self.enemyController, delta: delta)
                    self.frameCount += delta
                
                    // If frameCount is greater than 1.0
                    if self.frameCount >= 1.0 {
                        // Icrease player score
                        self.updateDistanceTic()
                        self.frameCount = 0.0
                    }
                } else {
                    // Player is out of lives
                    self.switchToGameOver()
                }
            case GameState.Paused:
                return
            
            case GameState.GameOver:
                return
        }
        self.player.update()
    }
    
    // MARK: - Contact
    func didBeginContact(contact: SKPhysicsContact) {
        if self.state != GameState.Running {
            return
        } else {
            
            // Player collisions
            if contact.bodyA.categoryBitMask == Contact.Player || contact.bodyB.categoryBitMask == Contact.Player {
                // Which body is not the player?
                let other = contact.bodyA.categoryBitMask == Contact.Player ? contact.bodyB : contact.bodyA
            
                if other.categoryBitMask == Contact.Meteor || other.categoryBitMask == Contact.Enemy || other.categoryBitMask == Contact.EnemyWeapon {
                    // If player is not immune
                
                    if !self.player.immune {
                        self.player.hitMeteor()
                        self.statusBar.updateLives(lives: self.player.lives)
                        // Remove the meteor from the screen
                        if let meteor = other.node as? Meteor {
                            meteor.hit(1, player: nil) // don't update the player score...
                        }
                        
                        if let enemy = other.node as? Enemy {
                            enemy.hit(1, player: nil) // don't update the player score...
                        }
                        
                        if let enemyWeapon = other.node as? EnemyWeapon {
                            enemyWeapon.hitWeapon() // don't update the player score...
                        }
                        
                    } else {
                        return // Player is immune
                    }
                }
            
                if other.categoryBitMask == Contact.Bonus {
                    if let bonus = other.node as? Bonus {
                        bonus.pickedUpBy(self.player, statusBar: self.statusBar)
                    }
                }
            }
            
            // Weapon collisions
            if contact.bodyA.categoryBitMask == Contact.Weapon || contact.bodyB.categoryBitMask == Contact.Weapon {
                let other = contact.bodyA.categoryBitMask == Contact.Weapon ? contact.bodyB : contact.bodyA
                let weapon = contact.bodyA.categoryBitMask != Contact.Weapon ? contact.bodyB : contact.bodyA
                
                if other.categoryBitMask == Contact.Meteor {
                    if let meteor = other.node as? Meteor {
                        // Remove the meteor from the screen
                        if let weapon = weapon.node as? Weapon {
                            let value = meteor.value
                            weapon.hitWeapon()
                            self.player.updatePlayerScore(score: value)
                        }
                        // Remove the meteor from the screen
                        meteor.hit(1, player: self.player)
                    }
                }
                
                if other.categoryBitMask == Contact.Enemy {
                    if let enemy = other.node as? Enemy {
                        // Remove the meteor from the screen
                        if let weapon = weapon.node as? Weapon {
                            weapon.hitWeapon()
                            enemy.hit(1, player: self.player) // damage done to the enemy
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Touch events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.locationInNode(self)
        
        switch self.state {
            case GameState.Tutorial:
                if self.startButton.containsPoint(touchLocation) {
                        self.startButton.tapped()
                        self.switchToRunning()
                }
                return
            case GameState.Running:
                self.player.updateTargetLocation(newLocation: touchLocation)
            case GameState.Paused:
                return
            case GameState.GameOver:
                return
        }
        
        self.player.updateTargetLocation(newLocation: touchLocation)
    }
    
    
    //MARK: - Load Scene
    private func loadGameOverScene(){
        //let gameOverScene = GameOverScene(size: kViewSize)
        let gameOverScene = GameOverScene(size: kViewSize, score: self.player.score, stars: self.player.starsCollected, streak: self.player.highStreak)
        let transition = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 0.25)
        self.view?.presentScene(gameOverScene, transition: transition)
        
    }
    
    private func switchToRunning() {
        self.state = GameState.Running
        self.player.enableMovement()
        
        // Move player to start position
        self.player.updateTargetLocation(newLocation: self.startButton.position)
        self.startButton.fadeStartButton()
        self.background.startBackground()
        self.meteorController.startSendingMeteors()
        self.weaponController.startFiringWeapons()
        self.enemyController.startSendingEnemies()
        self.enemyWeaponController.startFiringWeapons()
        // Start sending stars
        self.bonusController.startSendingBonuses()
    }
    
    private func switchToPaused() {
        self.state = GameState.Paused
    }
    
    
    private func switchToResume() {
        self.state = GameState.Running
    }
    
    private func switchToGameOver() {
        self.state = GameState.GameOver
        
        // Disable player movement
        self.player.disableMovement()
        
        // Update best score
        self.player.gameOver()
        
        // Stop background
        self.background.stopBackground()
        self.meteorController.stopSendingMeteors()
        self.bonusController.stopSendingBonuses()
        self.weaponController.stopFiringWeapons()
        self.enemyController.stopSendingEnemies()
        self.enemyWeaponController.stopFiringWeapons()
        // Switch to game over scene after 1.5 seconds
        self.runAction(SKAction.waitForDuration(1.5), completion: { self.loadGameOverScene() })
    }
    
    // MARK: - Scoring function
    private func updateDistanceTic() {
        self.player.updatePlayerScore(score: 1)
        self.statusBar.updateScore(score: self.player.score)
    }
}
