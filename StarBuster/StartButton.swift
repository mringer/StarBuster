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
    
    fileprivate override init(texture: SKTexture?, color:UIColor, size:CGSize){
        super.init(texture: texture, color:color, size:size)
    }
    
    convenience init(){
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.ButtonStart)
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        self.setupStartButton()
    }
    
    fileprivate func setupStartButton(){
        self.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.3)
    }
    
    //MARK: - Actions
    func tapped(){
        self.playSoundEffect(GameAudio.SoundEffect.ButtonTap)
    }
    
    func fadeStartButton() {
        self.run(SKAction.fadeOut(withDuration: 0.5), completion: {
            self.removeFromParent()
        }) 
    }
}

