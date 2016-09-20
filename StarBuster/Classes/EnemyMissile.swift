//
//  explosion.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/31/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//


import SpriteKit

class EnemyMissile: EnemyWeapon {
    
    fileprivate var frames = [SKTexture]()
    
    convenience init() {
        // TODO: magic string
        let animatedAtlas = SKTextureAtlas(named: "missile")
        var frames = [SKTexture]()
        
        for ( i, _ ) in animatedAtlas.textureNames.enumerated() {
            // TODO: magic string
            let textureName = "missile0\(i+1)"
            frames.append(animatedAtlas.textureNamed(textureName))
        }
        let scale:CGFloat = kDeviceTablet ? 0.50 : 0.25
        let firstFrame = frames[0]
        let size = firstFrame.size()
        self.init(texture: firstFrame, color: SKColor.white, size: CGSize(width: size.width * scale, height: size.height * scale ))
        self.frames = frames
        self.setupWeaponPhysics()
    }
    
    override func spawn(position: CGPoint, controller: EnemyController) {
        if let missile = self.copy() as? EnemyMissile {
            missile.position = position
            
            // Animation
            missile.run( SKAction.repeatForever(
                SKAction.animate(with: missile.frames,
                                 timePerFrame: 0.1,
                                 resize: false,
                                 restore: true)
            ))
            
            // Movement updates
            missile.run( SKAction.repeatForever(
                SKAction.sequence([ SKAction.wait(forDuration: missile.refreshRate),
                                    SKAction.run({ missile.update(delta: missile.refreshRate) })]
            )))
            
            controller.addChild(missile)
        }
    }
}
