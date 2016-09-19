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
    fileprivate let gameNode = SKNode()
    fileprivate let interfaceNode = SKNode()
    fileprivate let background = Background()
    fileprivate let startButton = StartButton()
    fileprivate let player = Player()
    fileprivate let meteorController = MeteorController()
    fileprivate let bonusController = BonusController()
    fileprivate let weaponController = WeaponController()
    fileprivate let enemyWeaponController = EnemyWeaponController()
    fileprivate let gameMenu = GameMenu(frame: CGRect(x: 0, y: 0, width: 400, height: 35))
    
    
    fileprivate let enemyController = EnemyController(enemiesArray: [Enemy(behaviors: CruiserFromRight()), Enemy(behaviors: CruiserFromLeft()), Enemy(behaviors: DiveBomber())])
    
    
    //private let enemyController = EnemyController(enemiesArray: [Enemy(behaviors: DiveBomber())])
    
    fileprivate enum GameState:Int {
        case tutorial
        case running
        case paused
        case gameOver
    }
    
    // Private Variables
    fileprivate var state = GameState.tutorial
    fileprivate var lastUpdateTime:TimeInterval = 0.0
    fileprivate var frameCount:TimeInterval = 0.0
    fileprivate var statusBar = StatusBar()
    fileprivate var previousState = GameState.tutorial
    
    //MARK: - Init
    required init?(coder aDecoder: NSCoder ){
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize){
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameScene.pauseGame), name: NSNotification.Name(rawValue: "PauseGame"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameScene.resumeGame), name: NSNotification.Name(rawValue: "ResumeGame"), object: nil)
        
        self.setupGameScene()
    }
    
    //MARK: - Setup
    fileprivate func setupGameScene(){
        //Set the background
        self.backgroundColor = SKColor.black

        self.physicsWorld.gravity = CGVector(dx: 0,dy: 0)
        self.physicsWorld.contactDelegate = self
        
        //Create Physics body for gameNode
        let screenBounds = CGRect(x: -self.player.size.width / 2, y: 0, width: kViewSize.width + self.player.size.width, height: kViewSize.height)
        gameNode.physicsBody = SKPhysicsBody(edgeLoopFrom: screenBounds)
        
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
    override func update(_ currentTime: TimeInterval){
        // Calculate delta
        let delta = currentTime - self.lastUpdateTime
        self.lastUpdateTime = currentTime
        
        switch self.state {
            case GameState.tutorial:
                return
        
            case GameState.running:
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
            case GameState.paused:
                return
            
            case GameState.gameOver:
                return
        }
        self.player.update()
    }
    
    // MARK: - Contact
    func didBegin(_ contact: SKPhysicsContact) {
        if self.state != GameState.running {
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
                        
                        self.flashBackground()
                        self.shakeScreen()
                        
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        switch self.state {
            case GameState.tutorial:
                if self.startButton.contains(touchLocation) {
                        self.startButton.tapped()
                        self.switchToRunning()
                }
                
                // TODO: just pause the game on app suspend.
                if self.statusBar.pauseButton.contains(touchLocation) {
                    self.pauseButtonPressed()
                }
                
                return
            
            case GameState.running:
                if self.statusBar.pauseButton.contains(touchLocation) {
                    self.pauseButtonPressed()
                    return // TODO: -
                } else {
                    // Move the player ship to the touch location.
                    self.player.updateTargetLocation(newLocation: touchLocation)
                }
            
            case GameState.paused:
                if self.statusBar.pauseButton.contains(touchLocation) {
                    self.pauseButtonPressed()
                    return
                }
            
            case GameState.gameOver:
                return
        }
        
        self.player.updateTargetLocation(newLocation: touchLocation)
    }
    
    
    //MARK: - Load Scene
    fileprivate func loadGameOverScene(){
        //let gameOverScene = GameOverScene(size: kViewSize)
        let gameOverScene = GameOverScene(size: kViewSize, score: self.player.score, stars: self.player.starsCollected, streak: self.player.highStreak)
        let transition = SKTransition.fade(with: SKColor.black, duration: 0.25)
        self.view?.presentScene(gameOverScene, transition: transition)
        
    }
    
    fileprivate func switchToRunning() {
        self.state = GameState.running
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
    
    //
    fileprivate func switchToPaused() {
        self.previousState = self.state
        self.state = GameState.paused
    }
    
    
    @objc fileprivate func switchToResume() {
        self.state = self.previousState
    }
    
    fileprivate func switchToGameOver() {
        self.state = GameState.gameOver
        
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
        self.run(SKAction.wait(forDuration: 1.5), completion: { self.loadGameOverScene() })
    }
    
    // MARK: - Scoring function
    fileprivate func updateDistanceTic() {
        self.player.updatePlayerScore(score: 1)
        self.statusBar.updateScore(score: self.player.score)
    }
    
    func pauseGame() {
        self.switchToPaused()
    }
    
    func resumeGame() {
        // Run a timer that resumes the game after 1 second
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(switchToResume), userInfo: nil, repeats: false)
    }
    
    // MARK: - Pause Button Actions
    fileprivate func pauseButtonPressed() {
        self.statusBar.pauseButton.tapped()
        
        if self.statusBar.pauseButton.getPausedState() {
            // Pause the gameNode
             self.gameNode.isPaused = true
            
            // Set the state to Paused
             self.switchToPaused()
            
            // pause the background music
            GameAudio.sharedInstance.pausedBackgroundMusic()
            
            //Add the game menu
            self.view?.addSubview(gameMenu)
            
        } else {
            // Resume the game
            self.gameNode.isPaused = false
            // Switch state to Running without doing the other in switchToResume()
            self.switchToResume()
            
            // Resume the background music
            GameAudio.sharedInstance.resumeBackgroundMusic()
            
            // remove the game menu
            gameMenu.removeFromSuperview()
        }
    }
    
    // MARK: - Scene Animation
    func flashBackground() {
        let colorFlash = SKAction.run( {
            self.backgroundColor = Colors.colorFromRGB(rgbValue: Colors.Magic)
            self.run(SKAction.wait(forDuration: 0.25), completion: {
                self.backgroundColor = Colors.colorFromRGB(rgbValue: Colors.Background)
            })
        })
        self.run(colorFlash)
    }
    
    func shakeScreen() {
        let shake = SKAction.screenShakeWithNode(self.gameNode, amount: CGPoint(x:20, y:15), oscillations: 10, duration: 0.75)
        self.run(shake)
    }
    
    // MARK: - deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
