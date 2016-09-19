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
    fileprivate let background = Background()
    fileprivate let gameTitle = GameTitle()
    
    fileprivate let gameTitleShip = GameTitleShip()
    fileprivate let gameTitlePlanet = GameTitlePlanet()
    fileprivate let playButton = PlayButton()
    
    //MARK: - Private class variable
//    private var sceneLabel = SKLabelNode()
    
    //MAARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        self.setupMenuScrene()
        GameAudio.sharedInstance.playBackgroundMusic(fileName: Music.Game)
    }
    
    //MARK: - Setup
    fileprivate func setupMenuScrene(){
        //Set the background color to black
        self.backgroundColor = Colors.colorFromRGB(rgbValue: Colors.Background)
        self.addChild(self.background)
        self.addChild(self.playButton)
        self.addChild(self.gameTitle)
        self.addChild(self.gameTitleShip)
        self.addChild(self.gameTitlePlanet)
    }
    
    //MARK: - Update
    override func update(_ currentTime: TimeInterval){
    }
    
    //MARK: Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        if self.playButton.contains(touchLocation){
            if kDebug{
                print("MenuScene: Loading Game Scene.")
            }
            self.playButton.tapped()
            self.loadGameScene()
        }
    }
    //MARK: -  Load Scene
    fileprivate func loadGameScene() {
        let gameScene = GameScene(size: kViewSize)
        let transition = SKTransition.fade(with: SKColor.black, duration: 0.25)
        self.view?.presentScene(gameScene, transition: transition)
    }
}

