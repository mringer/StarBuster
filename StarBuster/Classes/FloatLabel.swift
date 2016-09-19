//
//  FloatPoints.swift
//  StarBuster
//
//  Created by Matthew Ringer on 9/1/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class FloatLabel {
    
    static func spawn(_ anchor:SKNode, value:String) {
        
        let bonusLabel = GameFonts.sharedInstance.createLabel(string: value, labelType: GameFonts.LabelType.bonus)
        // Float the bonus on the screen
        bonusLabel.position = anchor.position
        anchor.parent?.addChild(bonusLabel)
        bonusLabel.run(GameFonts.sharedInstance.animateFloatingLables(node: bonusLabel))
        
    }
}
