//
//  ScoreBoard.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/23/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class ScoreBoard:SKNode {
    
    // MARK: - Private convenience constants
    fileprivate let fonts = GameFonts.sharedInstance
    fileprivate let fontType = GameFonts.LabelType.statusBar
    
    // MARK: - Private variables
    fileprivate var background = SKShapeNode()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
    }
    
    convenience init(score: Int, bestScore: Int, streak: Int, bestStreak: Int, stars: Int, bestStars: Int) {
        self.init()
        
        self.setupScoreBackground()
        self.setupScores(score, bestScore: bestScore, streak: streak, bestStreak: bestStreak, stars: stars, bestStars: bestStars)
    }
    
    // MARK: - Setup
    fileprivate func setupScoreBackground() {
        
        // Rectangle that is 90% of the width and 25% of the height of the screen
        let backgroundRect = CGRect(x: 0, y: 0, width: kViewSize.width * 0.9, height: kViewSize.height * 0.25)
        self.background = SKShapeNode(rect: backgroundRect, cornerRadius: 5.0)
        
        // Give background a border stroke
        self.background.strokeColor = Colors.colorFromRGB(rgbValue: Colors.Border)
        self.background.lineWidth = 1.5
        
        self.background.position = CGPoint(x: kViewSize.width * 0.05, y: kViewSize.height * 0.35)
        
        self.addChild(self.background)
    }
    
    fileprivate func setupScores(_ score: Int, bestScore: Int, streak: Int, bestStreak: Int, stars: Int, bestStars: Int) {
        
        // Width and height conveience constants
        let frameWidth = self.background.frame.width
        let frameHeight = self.background.frame.height
        
        // Labels
        let scoreLable = fonts.createLabel(string: "Score:", labelType: fontType)
        let bestScoreLable = fonts.createLabel(string: "Best:", labelType: fontType)
        let streakLable = fonts.createLabel(string: "Streak:", labelType: fontType)
        let bestStreakLable = fonts.createLabel(string: "Best:", labelType: fontType)
        let starsLable = fonts.createLabel(string: "Stars:", labelType: fontType)
        let bestStarsLable = fonts.createLabel(string: "Best:", labelType: fontType)
        
        // Scores 
        let scoreValue = fonts.createLabel(string: String(score), labelType: fontType)
        let bestScoreValue = fonts.createLabel(string: String(bestScore), labelType: fontType)
        let streakValue = fonts.createLabel(string: String(streak), labelType: fontType)
        let bestStreakValue = fonts.createLabel(string: String(bestStreak), labelType: fontType)
        let starsValue = fonts.createLabel(string: String(stars), labelType: fontType)
        let bestStarsValue = fonts.createLabel(string: String(bestStars), labelType: fontType)
        
        // Positioning 
        scoreLable.position = CGPoint(x: frameWidth * 0.05, y: frameHeight * 0.75)
        scoreValue.position = CGPoint(x: frameWidth * 0.25, y: frameHeight * 0.75)
        
        bestScoreLable.position = CGPoint(x: frameWidth * 0.5, y: frameHeight * 0.75)
        bestScoreValue.position = CGPoint(x: frameWidth * 0.7, y: frameHeight * 0.75)
        
        streakLable.position = CGPoint(x: frameWidth * 0.05, y: frameHeight * 0.5)
        streakValue.position = CGPoint(x: frameWidth * 0.25, y: frameHeight * 0.5)
        
        bestStreakLable.position = CGPoint(x: frameWidth * 0.5, y: frameHeight * 0.5)
        bestStreakValue.position = CGPoint(x: frameWidth * 0.7, y: frameHeight * 0.5)
        
        starsLable.position = CGPoint(x: frameWidth * 0.05, y: frameHeight * 0.25)
        starsValue.position = CGPoint(x: frameWidth * 0.25, y: frameHeight * 0.25)
        
        bestStarsLable.position = CGPoint(x: frameWidth * 0.5, y: frameHeight * 0.25)
        bestStarsValue.position = CGPoint(x: frameWidth * 0.7, y: frameHeight * 0.25)
        
        // Add to background
        self.background.addChild(scoreLable)
        self.background.addChild(scoreValue)

        self.background.addChild(bestScoreLable)
        self.background.addChild(bestScoreValue)
        
        self.background.addChild(streakLable)
        self.background.addChild(streakValue)
        
        self.background.addChild(bestStreakLable)
        self.background.addChild(bestStreakValue)
        
        self.background.addChild(starsLable)
        self.background.addChild(starsValue)
        
        self.background.addChild(bestStarsLable)
        self.background.addChild(bestStarsValue)
    }
}
