//
//  EnemyWeaponControler.swift
//  StarBuster
//
//  Created by Matthew Ringer on 9/2/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class EnemyWeaponController:SKNode {
    
    // MARK: - Private class variables
    fileprivate var firingWeapons = true // TODO:
    fileprivate var movingWeapons = true // TODO:
    fileprivate var frameCount = 0.0
    fileprivate var weaponArray:[EnemyWeapon] = [EnemyWeapon]()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(){
        super.init()
        self.setupWeaponController()
    }
    
    convenience init(weapons:[EnemyWeapon]){
        self.init()
        for weapon in weapons {
            self.weaponArray.append(weapon)
        }
    }
    
    fileprivate func setupWeaponController() {
        ///self.weaponArray = [EnemyWeapon]()
    }
    
    // MARK: - Update
    func update(_ enemyController:EnemyController, delta: TimeInterval) {
        
        
        //Move the weapons on screen
        if self.movingWeapons {
            for node in self.children {
                if let weapon = node as? EnemyWeapon {
                    weapon.update(delta: delta)
                }
            }
        }
        
        for (_, child) in enemyController.children.enumerated() {
            if let enemy = child as? Enemy {
                // Is it time to fire the guns?
                if self.firingWeapons {
                    self.frameCount += delta
                    
                    if self.frameCount >= 2.0 { // TODO: individualize weapons to the type
                        // Approximatly 3 seconds have passed, spawn more
                        for weapon in enemy.behaviors.weapons {
                            weapon.behaviors.spawn(weapon, enemy: enemy, controller: self)
                        }
                        self.frameCount = 0.0
                    }
                }
            }
        }
    }
    
    // MARK: - Action function
    func startFiringWeapons() {
        self.firingWeapons = true
        self.movingWeapons = true
    }
    
    func stopFiringWeapons() {
        self.firingWeapons = false
        self.movingWeapons = false
    }
    
    fileprivate func gameOver() {
        for node in self.children {
            if let meteor = node as? Meteor {
                meteor.gameOver()
            }
        }
    }
}

