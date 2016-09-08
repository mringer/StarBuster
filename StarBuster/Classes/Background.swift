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
    private let backgroundRunSpeed:CGFloat = -200.0
    private let backgroundStopSpeed:CGFloat = -25.0
    
    // MARK: - Private Class Variables
    private var backgroundParticles = SKEmitterNode()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder ){
        super.init(coder: aDecoder )
    }
    
    override init(){
        super.init()
        
        self.setupBackground()
    }
    
    // Mark: - Private functions
    private func setupBackground(){
        self.backgroundParticles = GameParticles.sharedInstnce.createParticle(particles: GameParticles.Particles.Magic)
        self.addChild(self.backgroundParticles)
        self.stopBackground()
    }
    
    //MARK: - Action
    func startBackground(){
        self.backgroundParticles.particleSpeed = self.backgroundRunSpeed
        self.backgroundParticles.particleSpeedRange = self.backgroundRunSpeed / 4
    }
    
    func stopBackground(){
        self.backgroundParticles.particleSpeed = self.backgroundStopSpeed
        self.backgroundParticles.particleSpeedRange = self.backgroundStopSpeed / 4
    }
    
    
    
}
