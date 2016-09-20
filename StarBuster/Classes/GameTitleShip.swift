//
//  GameTitle.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/7/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class GameTitleShip:SKSpriteNode{
    
    // MARK: Private variables
    fileprivate var animation = SKAction()
    
    //MARK: - Init
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    fileprivate override init(texture:SKTexture?, color: UIColor, size: CGSize){
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.Player)
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        self.setupGameTitleShip()
        self.setupAnimation()
    }
    
    fileprivate func setupAnimation() {
        let moveOut = SKAction.move(to: CGPoint(x: kViewSize.width / 2, y: kViewSize.height + self.frame.height * 2 ), duration: 0.5)
        //let scaleUp = SKAction.scale(to: 1.1, duration: 0.125)
        //let scaleNormal = SKAction.scale(to: 1.0, duration: 0.125)
        self.animation = SKAction.sequence([moveOut]) //, scaleUp, scaleNormal])
    }
    
    fileprivate func setupGameTitleShip(){
        self.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height / 2)
        self.zPosition = GameLayer.Player
    }
    
    func animateOut() -> SKAction {
        //self.run(self.animation, completion: {self.removeFromParent()})
        return self.animation
    }
}
