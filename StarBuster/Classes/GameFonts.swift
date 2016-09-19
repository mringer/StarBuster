//
//  GameFonts.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/8/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

let GameFontSharedInstance = GameFonts()

class GameFonts {
    
    class var sharedInstance:GameFonts {
        return GameFontSharedInstance
    }
    
    // MARK: - Public enum
    internal enum LabelType:Int {
        case statusBar
        case bonus
        case message
    }
    
    // MARK: - Private class constants
    fileprivate let fontName = "Edit Undo BRK"
    fileprivate let scoreSizePad:CGFloat = 24.0
    fileprivate let scoreSizePhone:CGFloat = 16.0
    fileprivate let bonusSizePad:CGFloat = 72.0
    fileprivate let bonusSizePhone:CGFloat = 36.0
    fileprivate let messageSizePad:CGFloat = 48.0
    fileprivate let messageSizePhone:CGFloat = 24.0
    
    // MARK: - Private class variables
    fileprivate var label = SKLabelNode()
    
    // MARK: - Init
    init() {
        self.setupLable()
    }
    
    // MARK: - Setup
    fileprivate func setupLable() {
        self.label = SKLabelNode(fontNamed: self.fontName)
        self.label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
    }
    
    // MARK: - Label creation
    func createLabel(string: String, labelType: LabelType ) -> SKLabelNode {
        let  copiedLable = self.label.copy() as! SKLabelNode
        switch labelType {
        case LabelType.statusBar:
            copiedLable.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            copiedLable.fontColor = Colors.colorFromRGB(rgbValue: Colors.FontScore)
            copiedLable.fontSize = kDeviceTablet ? self.scoreSizePad : self.scoreSizePhone
            copiedLable.text = string
        case LabelType.bonus:
            copiedLable.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            copiedLable.fontColor = Colors.colorFromRGB(rgbValue: Colors.FontBonus)
            copiedLable.fontSize = kDeviceTablet ? self.scoreSizePad : self.scoreSizePhone
            copiedLable.text = string
        case LabelType.message:
            copiedLable.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            copiedLable.fontColor = Colors.colorFromRGB(rgbValue: Colors.FontScore)
            copiedLable.fontSize = kDeviceTablet ? self.scoreSizePad : self.scoreSizePhone
            copiedLable.text = string
            
        }
        
        return copiedLable
    }
    
    //MARK: - Actions
    func animateFloatingLables(node:SKNode) -> SKAction {
        let action = SKAction.run({
            node.run(SKAction.fadeIn(withDuration: 0.1), completion: {
                node.run(SKAction.moveTo(y: node.position.y + node.frame.size.height * 2, duration: 0.1), completion: {
                    node.removeFromParent()
                })
            })
        })
        return action
    }
}
