//
//  WeaponController.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/8/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class WeaponController:SKNode {
    
    //private let laser = Weapon(type: Weapon.WeaponType.Laser)
    
    // MARK: - Private class variables
    fileprivate var firingWeapons = false
    fileprivate var movingWeapons = false
    fileprivate var frameCount = 0.0
    //private var weaponArray = [SKSpriteNode]()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(){
        super.init()
        self.setupWeaponController()
    }
    
    fileprivate func setupWeaponController() {
        //self.weaponArray = [self.laser]
    }
    
    // MARK: - Update
    func update(delta: TimeInterval, player: Player) {
        // Is it time to fire the guns?
        if self.firingWeapons {
            self.frameCount += delta
        }
        
        //Move the meteors on screen
        if self.movingWeapons {
            for node in self.children {
                if let weapon = node as? Weapon {
                    weapon.update(delta: delta)
                }
            }
        }
    }
    
    //MARK: - Spawn Weapons
    func spawnWeapons(player: Player) {
        if self.firingWeapons {
            for ( i, _ ) in player.weapons.enumerated() {
                // Copy from array
                if  let weapon = player.weapons[i].copy() as? Weapon {
                    let laserSpacing = weapon.size.width * 10
                    // Center the lasers on even numbers
                    let modOffset = CGFloat( (player.weapons.count + 1) % 2 ) * laserSpacing / 2
                    let laserXOffset = laserSpacing * CGFloat(player.weapons.count / 2) - modOffset
                    weapon.position = CGPoint(x: player.position.x + laserSpacing * CGFloat(i) - laserXOffset, y: player.position.y + weapon.size.height)
                    
                    
                    self.addChild(weapon)
                }
            }
        }
    }
    
    // MARK: - Action function
    func setWeaponsOn(_ on:Bool) {
        self.firingWeapons = on
        self.movingWeapons = on
    }
    
    fileprivate func gameOver() {
        for node in self.children {
            if let meteor = node as? Meteor {
                meteor.gameOver()
            }
        }
    }
}
