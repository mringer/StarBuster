//
//  SpriteAnimation.swift
//  StarBuster
//
//  Created by Matthew Ringer on 9/14/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class SpriteAnimation {
    
   static func animateBounce() -> SKAction {
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.12)
        let scaleNormal = SKAction.scale(to: 1.0, duration: 0.12)
        let scaleSequence = SKAction.sequence([scaleUp, scaleNormal])
        return scaleSequence
    }
}
