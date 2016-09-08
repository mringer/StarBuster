//
//  GameOverTitle.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/23/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class GameOverTitle:SKSpriteNode {
    
    // MARK: - Init 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.TitleGameOver)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        self.setupGameOverTitle()
    }
    
    // MARK: - Setup GameOverTitle 
    private func setupGameOverTitle() {
        self.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.7)
    }
}
