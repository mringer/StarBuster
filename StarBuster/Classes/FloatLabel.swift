//
//  FloatPoints.swift
//  StarBuster
//
//  Created by Matthew Ringer on 9/1/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class FloatLabel {
    
    static func spawn(_ position:CGPoint, text:String) -> SKLabelNode {
        
        let bonusLabel = GameFonts.sharedInstance.createLabel(string: text, labelType: GameFonts.LabelType.bonus)
        // Float the bonus on the screen
        bonusLabel.position = position
        bonusLabel.zPosition = GameLayer.Explosion
        bonusLabel.run(GameFonts.sharedInstance.animateFloatingLables(node: bonusLabel))
        return bonusLabel
    }
}
