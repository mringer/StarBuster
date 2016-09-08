//
//  explosion.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/31/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//


import SpriteKit

public class Explosion:SKSpriteNode {

    private var explosionFrames = [SKTexture]()
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        
        // TODO: magic string
        let animatedAtlas = SKTextureAtlas(named: "explosion")
        var frames = [SKTexture]()
        
        for ( i, _ ) in animatedAtlas.textureNames.enumerate() {
            // TODO: magic string
            let textureName = "explosion\(i+1)"
            frames.append(animatedAtlas.textureNamed(textureName))
        }
        
        let firstFrame = frames[0]
        let size = firstFrame.size()
        self.init(texture: firstFrame, color: SKColor.whiteColor(), size: size )
        self.explosionFrames = frames
    }
    
    func runAndExit() {
        self.runAction(
            SKAction.animateWithTextures(self.explosionFrames,
                timePerFrame: 0.1,
                resize: false,
                restore: true),
            completion: { self.removeFromParent()
        })
    }
}