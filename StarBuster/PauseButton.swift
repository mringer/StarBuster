//
//  PauseButton.swift
//  StarBuster
//
//  Created by Matthew Ringer on 9/13/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class PauseButton:SKSpriteNode {
    
    // MARK: - Private class constant
    private let pasueTexture = GameTextures.sharedInstance.textureWithName(name: SpriteName.ButtonPause)
    private let resumeTexture = GameTextures.sharedInstance.textureWithName(name: SpriteName.ButtonResume)
    
    // MARK: - Private class variables
    private var gamePaused = false
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture?, color:UIColor, size:CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.ButtonPause)
        self.init(texture:texture, color:SKColor.whiteColor(), size: texture.size())
        self.setupPauseButton()
    }
    
    // MARK: - Setup
    private func setupPauseButton() {
        // Put the anchorPoint in the top right corner of the sprite
        self.anchorPoint = CGPoint(x:1.0, y:1.0)
        
        // Position at top right corner of screen
        self.position = CGPoint(x: kViewSize.width, y: kViewSize.height)
    }
    // MARK: - Actions 
    func tapped() {
        self.runAction(GameAudio.sharedInstance.soundButtonTap)
        
        // Set the value of gamePaused and update the texture.
        self.gamePaused = !self.gamePaused
        self.texture = self.gamePaused ? self.resumeTexture : self.pasueTexture
    }
    
    func getPausedState() -> Bool {
        return self.gamePaused
    }
}