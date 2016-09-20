//
//  explosion.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/31/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//


import SpriteKit

class Explosion:SKSpriteNode {

    fileprivate var explosionFrames = [SKTexture]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(position:CGPoint) {
        
        // TODO: magic string
        let animatedAtlas = SKTextureAtlas(named: "explosion")
        var frames = [SKTexture]()
        
        for ( i, _ ) in animatedAtlas.textureNames.enumerated() {
            // TODO: magic string
            let textureName = "explosion\(i+1)"
            frames.append(animatedAtlas.textureNamed(textureName))
        }
        
        let firstFrame = frames[0]
        let size = firstFrame.size()
        self.init(texture: firstFrame, color: SKColor.white, size: size )
        self.explosionFrames = frames
        self.position = position
        self.zPosition = GameLayer.Explosion
        
        self.setScale(  kDeviceTablet ? 2.0 : 1.0 )
    }
    
    func runAndExit() {
        self.playSoundEffect(GameAudio.SoundEffect.Explosion)
        self.run(
            SKAction.animate(with: self.explosionFrames,
                timePerFrame: 0.1,
                resize: false,
                restore: true),
            completion: { self.removeFromParent() }
        )
    }
}


extension SKSpriteNode {
    
    func BigBoom(radius: CGFloat, count: Int) {
        let position = self.position
        for _ in 1...count {
            let explosion = Explosion(position: position)
            self.parent?.addChild(explosion)
            explosion.position = CGPoint(x: self.position.x - RandomFloatRange(min: CGFloat(radius * -1), max: radius), y: self.position.y - RandomFloatRange(min: CGFloat(radius * -1), max: radius))
            explosion.runAndExit()
        }
    }
}
