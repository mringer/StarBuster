//
//  RetryButton.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/7/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class RetryButton:SKSpriteNode {
    
    //MARK: - Init
    required init?(coder aDecoder: NSCoder){
        super.init(coder:aDecoder)
    }
    
    fileprivate override init(texture: SKTexture?, color:UIColor, size:CGSize){
        super.init(texture: texture, color:color, size:size)
    }
    
    convenience init(){
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.ButtonRetry)
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        self.setupRetryButton()
    }
    
    fileprivate func setupRetryButton(){
        self.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.3)
    }
    
    //MARK: - Actions
    func tapped() {
        self.playSoundEffect(GameAudio.SoundEffect.ButtonTap)
    }
}
