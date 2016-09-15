//
//  GameTitle.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/7/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class GameTitle:SKSpriteNode{
    
    // MARK: Private variables
    private var animation = SKAction()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    private override init(texture:SKTexture?, color: UIColor, size: CGSize){
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.TitleGame)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        self.setupGameTitle()
        self.setupAnimation()
        self.animateIn()
    }
    
    private func setupGameTitle(){
        self.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height / 2)        
        //self.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.7)
    }
    
    private func setupAnimation() {
        let moveIn = SKAction.moveTo(CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.7), duration: 0.5)
        let scaleUp = SKAction.scaleTo(1.1, duration: 0.125)
        let scaleNormal = SKAction.scaleTo(1.0, duration: 0.125)
        self.animation = SKAction.sequence([moveIn, scaleUp, scaleNormal])
    }
    
    private func animateIn() {
        self.runAction(self.animation)
    }
}