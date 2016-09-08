//
//  GameOverScene.swift
//  StarBuster
//
//  Created by Matthew Ringer on 7/22/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene:SKScene {
    //MARK: - Private class contant
    private let background = Background()
    private let retryButton = RetryButton()
    private let gameOverTitle = GameOverTitle()
    
    //MARK: - Private class variable
//    private var sceneLabel = SKLabelNode()
    private var scoreBoard = ScoreBoard()
    
    //MAARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    convenience init(size: CGSize, score: Int, stars: Int, streak: Int) {
        self.init(size: size)
        self.setupScoreBoard(score, stars: stars, streak: streak)
    }
    
    override func didMoveToView(view: SKView) {
        self.setupGameOverScrene()
    }
    
    //MARK: - Setup
    private func setupGameOverScrene(){
        //Set the background color to black
        self.backgroundColor = Colors.colorFromRGB(rgbValue: Colors.Background)
        self.addChild(self.background)
        self.addChild(self.retryButton)
        self.addChild(self.gameOverTitle)
    }
    
    private func setupScoreBoard(score: Int, stars: Int, streak: Int) {
        let bestScore = GameSettings.sharedInstance.getBestScore()
        let bestStars = GameSettings.sharedInstance.getBestStars()
        let bestStreak = GameSettings.sharedInstance.getBestStreak()
        
        self.scoreBoard = ScoreBoard(score: score, bestScore: bestScore, streak: streak, bestStreak: bestStreak, stars: stars, bestStars: bestStars)
        
        self.addChild(self.scoreBoard)
    }
    
    //MARK: - Update
    override func update(currentTime: NSTimeInterval){
    }
    
    //MARK: Touch Events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.locationInNode(self)
        
        if self.retryButton.containsPoint(touchLocation){
            if kDebug{
                print("GameOverScene: Loading Menu Scene.")
                
            }
            
            //self.loadMenuScene()
            self.loadGameScene()
        }
    }
    //MARK: -  Load Scene
    private func loadMenuScene() {
        let menuScene = MenuScene(size: kViewSize)
        let transition = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 0.25)
        self.view?.presentScene(menuScene, transition: transition)
    }
    
    private func loadGameScene() {
        let gameScene = GameScene(size: kViewSize)
        let transition = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 0.25)
        self.view?.presentScene(gameScene, transition: transition)
    }
}

