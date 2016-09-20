//
//  Background.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/2/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class Background:SKNode{
    
    // Mark: - Private class constants
    fileprivate let backgroundRunSpeed:CGFloat = -200.0
    fileprivate let backgroundStopSpeed:CGFloat = -25.0
    
    // MARK: - Private Class Variables
    fileprivate var backgroundParticles = SKEmitterNode()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder ){
        super.init(coder: aDecoder )
    }
    
    override init(){
        super.init()
        
        self.setupBackground()
    }
    
    // Mark: - Private functions
    fileprivate func setupBackground(){
        self.backgroundParticles = GameParticles.sharedInstnce.createParticle(particles: GameParticles.Particles.magic)
        self.backgroundParticles.zPosition = GameLayer.BackgroundLow
        self.addChild(self.backgroundParticles)
        self.setBackgroundOn(false)
    }
    
    //MARK: - Action
    func setBackgroundOn(_ on:Bool){
        if on {
            self.backgroundParticles.particleSpeed = self.backgroundRunSpeed
            self.backgroundParticles.particleSpeedRange = self.backgroundRunSpeed / 4
        }else{
            self.backgroundParticles.particleSpeed = self.backgroundStopSpeed
            self.backgroundParticles.particleSpeedRange = self.backgroundStopSpeed / 4
        }
    }
}
