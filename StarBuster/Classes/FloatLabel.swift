//
//  FloatPoints.swift
//  StarBuster
//
//  Created by Matthew Ringer on 9/1/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class FloatLabel {
    
    static func spawn(anchor:SKNode, value:String) {
        
        let bonusLabel = GameFonts.sharedInstance.createLabel(string: value, labelType: GameFonts.LabelType.Bonus)
        // Float the bonus on the screen
        bonusLabel.position = anchor.position
        anchor.parent?.addChild(bonusLabel)
        bonusLabel.runAction(GameFonts.sharedInstance.animateFloatingLables(node: bonusLabel))
        
    }
}
