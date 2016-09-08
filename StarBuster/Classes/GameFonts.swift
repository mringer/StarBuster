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
        case StatusBar
        case Bonus
        case Message
    }
    
    // MARK: - Private class constants
    private let fontName = "Edit Undo BRK"
    private let scoreSizePad:CGFloat = 24.0
    private let scoreSizePhone:CGFloat = 16.0
    private let bonusSizePad:CGFloat = 72.0
    private let bonusSizePhone:CGFloat = 36.0
    private let messageSizePad:CGFloat = 48.0
    private let messageSizePhone:CGFloat = 24.0
    
    // MARK: - Private class variables
    private var label = SKLabelNode()
    
    // MARK: - Init
    init() {
        self.setupLable()
    }
    
    // MARK: - Setup
    private func setupLable() {
        self.label = SKLabelNode(fontNamed: self.fontName)
        self.label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
    }
    
    // MARK: - Label creation
    func createLabel(string string: String, labelType: LabelType ) -> SKLabelNode {
        let  copiedLable = self.label.copy() as! SKLabelNode
        switch labelType {
        case LabelType.StatusBar:
            copiedLable.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
            copiedLable.fontColor = Colors.colorFromRGB(rgbValue: Colors.FontScore)
            copiedLable.fontSize = kDeviceTablet ? self.scoreSizePad : self.scoreSizePhone
            copiedLable.text = string
        case LabelType.Bonus:
            copiedLable.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
            copiedLable.fontColor = Colors.colorFromRGB(rgbValue: Colors.FontBonus)
            copiedLable.fontSize = kDeviceTablet ? self.scoreSizePad : self.scoreSizePhone
            copiedLable.text = string
        case LabelType.Message:
            copiedLable.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
            copiedLable.fontColor = Colors.colorFromRGB(rgbValue: Colors.FontScore)
            copiedLable.fontSize = kDeviceTablet ? self.scoreSizePad : self.scoreSizePhone
            copiedLable.text = string
            
        }
        
        return copiedLable
    }
    
    //MARK: - Actions
    func animateFloatingLables(node node:SKNode) -> SKAction {
        let action = SKAction.runBlock({
            node.runAction(SKAction.fadeInWithDuration(0.1), completion: {
                node.runAction(SKAction.moveToY(node.position.y + node.frame.size.height * 2, duration: 0.1), completion: {
                    node.removeFromParent()
                })
            })
        })
        return action
    }
}
