//
//  StartButton.swift
//  SpaceRunner
//
//  Created by Matthew Ringer on 8/7/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class StartButton:SKSpriteNode {
    
    //MARK: - Init
    required init?(coder aDecoder: NSCoder){
        super.init(coder:aDecoder)
    }
    
    private override init(texture: SKTexture?, color:UIColor, size:CGSize){
        super.init(texture: texture, color:color, size:size)
    }
    
    convenience init(){
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.ButtonStart)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        self.setupStartButton()
    }
    
    private func setupStartButton(){
        self.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.3)
    }
    
    //MARK: - Actions
    func tapped(){
        self.runAction(GameAudio.sharedInstance.soundButtonTap)
    }
    
    func fadeStartButton() {
        self.runAction(SKAction.fadeOutWithDuration(0.5)) {
            self.removeFromParent()
        }
    }
}

