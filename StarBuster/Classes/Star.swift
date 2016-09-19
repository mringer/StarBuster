//
//  Star.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/14/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class Star:BonusBehaviors {
    
    var texture:SKTexture = SKTexture()
    
    init(){
        self.texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.Star)
    }
    
    func bonusPickedUpBy(_ player:Player, statusBar:StatusBar) {
        player.starsCollected += 1
        player.streakCount += 1
        
        //Update Player's score on the Status Bar
        statusBar.updateScore(score: player.score)
        // update the players star count on contact with star
        statusBar.updateStarsCollected(collected: player.starsCollected)
        
        if player.weapons.count < 5 {
            // Add up to 5 laser
            player.weapons.append(Weapon(type: Weapon.WeaponType.laser))
        }
        
        player.checkStreak(streak: player.streakCount)
        var bonus = ""
        switch player.streakCount {
            
        case 0..<5:
            player.score += 250
            bonus = String(250)
            
        case 5..<10:
            player.score += 500
            bonus = String(250)
            
        case 10..<15:
            player.score += 750
            bonus = String(750)
            
        case 15..<20:
            player.score += 1000
            bonus = String(1000)
            
        case 20..<25:
            player.score += 1250
            bonus = String(1250)
            
        case 25..<30:
            player.score += 1500
            bonus = String(1500)
            
        case 30..<35:
            player.score += 1750
            bonus = String(1750)
            
        case 35..<40:
            player.score += 2000
            bonus = String(2000)
            
        case 40..<45:
            player.score += 2250
            bonus = String(2250)
            
        case 40..<45:
            player.score += 2500
            bonus = String(2500)
            
        default:
            player.score += 5000
            bonus = String(5000)
        }
        
        // Float the bonus on the screen
        FloatLabel.spawn(player, value: bonus)
    }
}
