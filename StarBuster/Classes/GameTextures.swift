//
//  GameTextures.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/2/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

let GameTexturesSharedInstance = GameTextures()

class GameTextures {
    class var sharedInstance:GameTextures {
        return GameTexturesSharedInstance
    }
    // MARK: - Private class variables
    private var interfaceSpritesAtlas = SKTextureAtlas()
    private var gameSpriteAtlas = SKTextureAtlas()
    
    // MARK: - Init
    init(){
        self.interfaceSpritesAtlas = SKTextureAtlas(named:"InterfaceSprites")
        self.gameSpriteAtlas = SKTextureAtlas(named: "GameSprites")
    }
    
    // MARK: - public convenience functions
    func textureWithName(name name:String) -> SKTexture {
        return SKTexture(imageNamed: name)
    }
    
    func spriteWithName(name name:String) -> SKSpriteNode{
        return SKSpriteNode(imageNamed: name)
    }
}

