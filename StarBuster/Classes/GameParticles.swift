//
//  GameParticles.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/2/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

let GameParticlesSharedInstance = GameParticles()

class GameParticles {
    
    class var sharedInstnce:GameParticles {
        return GameParticlesSharedInstance
    }
    
    // MARK: - Public class enum
    internal enum Particles:Int {
        case magic
    }
    
    // MARK: - Private class properties
    fileprivate var magicParticles = SKEmitterNode()
    
    // MARK: - Init 
    
    init() {
        self.setupMagicParticles()
    }
    
    // MARK: - Setup
    fileprivate func setupMagicParticles(){
        
        // Birthrate and Lifetime
        self.magicParticles.particleBirthRate = 35.0
        self.magicParticles.particleLifetime = 5.0
        self.magicParticles.particleLifetimeRange = 1.25
        
        // Position and Range
        self.magicParticles.particlePositionRange = CGVector(dx: kViewSize.width * 2, dy: kViewSize.height * 2)
        
        // Speed
        self.magicParticles.particleSpeed = -200.0
        self.magicParticles.particleSpeedRange = self.magicParticles.particleSpeed / 4
        
        // Emmition Angle 
        self.magicParticles.emissionAngle = DegreesToRadians(degrees: 90.0)
        self.magicParticles.emissionAngleRange = DegreesToRadians(degrees: 15)
        
        // Alpha
        self.magicParticles.particleAlpha = 0.5
        self.magicParticles.particleAlphaRange = 0.25
        self.magicParticles.particleAlphaSpeed = -0.125
        
        // Color Blending
        self.magicParticles.particleColorBlendFactor = 0.5
        self.magicParticles.particleColorBlendFactorRange = 0.25
        
        // Color
        self.magicParticles.particleColor = Colors.colorFromRGB(rgbValue: Colors.Magic)
        
        // Texture
        self.magicParticles.particleTexture = GameTextures.sharedInstance.textureWithName(name: SpriteName.Magic)
        
    }
    
    // MARK: - Public functions
    func createParticle(particles: Particles) -> SKEmitterNode {
        switch particles {
        case Particles.magic:
            return self.magicParticles.copy() as! SKEmitterNode
        }
    }
}
