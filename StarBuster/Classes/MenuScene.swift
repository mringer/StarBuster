//
//  MenuScene.swift
//  StarBuster
//
//  Created by Matthew Ringer on 7/22/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene:SKScene {
    
    //MARK: - Private class contant
    private let background = Background()
    private let gameTitle = GameTitle()
    private let gameTitleShip = GameTitleShip()
    private let playButton = PlayButton()
    
    //MARK: - Private class variable
//    private var sceneLabel = SKLabelNode()
    
    //MAARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMoveToView(view: SKView) {
        self.setupMenuScrene()
    }
    
    //MARK: - Setup
    private func setupMenuScrene(){
        //Set the background color to black
        self.backgroundColor = Colors.colorFromRGB(rgbValue: Colors.Background)
        self.addChild(self.background)
        
        //Initialize a temporary lable and add it to the scene
//        self.sceneLabel.fontName = "ChalkDuster"
//        self.sceneLabel.color = SKColor.whiteColor()
//        self.sceneLabel.fontSize = kViewSize.width * 0.1
//        self.sceneLabel.text = "Menu Scene"
//        self.sceneLabel.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height / 2)
        self.addChild(self.playButton)
        self.addChild(self.gameTitle)
        self.addChild(self.gameTitleShip)
    }
    
    //MARK: - Update
    override func update(currentTime: NSTimeInterval){
    }
    
    //MARK: Touch Events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.locationInNode(self)
        
        if self.playButton.containsPoint(touchLocation){
            if kDebug{
                print("MenuScene: Loading Game Scene.")
                
            }
            self.loadGameScene()
        }
    }
    //MARK: -  Load Scene
    private func loadGameScene() {
        let gameScene = GameScene(size: kViewSize)
        let transition = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 0.25)
        self.view?.presentScene(gameScene, transition: transition)
    }
}

