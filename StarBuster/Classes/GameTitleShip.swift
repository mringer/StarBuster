//
//  GameTitle.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/7/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class GameTitleShip:SKSpriteNode{
    
    //MARK: - Init
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    private override init(texture:SKTexture?, color: UIColor, size: CGSize){
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.TitleGameShip)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        self.setupGameTitleShip()
    }
    
    private func setupGameTitleShip(){
        self.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height / 2)
        self.zPosition = 10
    }
}