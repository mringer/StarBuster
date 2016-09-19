//
//  EnemyController.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/8/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class EnemyController:SKNode {
    
    // MARK: - Private class variables
    fileprivate var sendingEnemies = false
    fileprivate var movingEnemies = false
    fileprivate var frameCount = 0.0
    fileprivate var spawnRate = 6.0
    fileprivate var enemyArray = [Enemy]()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(){
        super.init()
        self.setupController()
    }
    
    convenience init(enemiesArray: [Enemy]){
        self.init()
        self.enemyArray = enemiesArray
    }
    
    fileprivate func setupController() {
        self.enemyArray = [Enemy()]
    }
    
    // MARK: - Update
    func update(delta: TimeInterval) {
        // Is it time to send more meteors?
        if self.sendingEnemies {
            self.frameCount += delta
            if self.frameCount > spawnRate {
                let randomEnemyIndex  = RandomIntegerBetween(min: 0, max: self.enemyArray.count - 1)
                if let enemy = self.enemyArray[randomEnemyIndex].copy() as? Enemy {
                    enemy.spawnEnemy(self)
                }
                self.frameCount = 0.0
            }
        }
        
        //Move the meteors on screen
        if self.movingEnemies {
            for node in self.children {
                if let enemy = node as? Enemy {
                    enemy.update(delta: delta)
                }
            }
        }
    }
    
    // MARK: - Action function
    func startSendingEnemies() {
        self.sendingEnemies = true
        self.movingEnemies = true
    }
    
    func stopSendingEnemies() {
        self.sendingEnemies = false
        self.movingEnemies = false
    }
    
    fileprivate func gameOver() {
        for node in self.children {
            if let meteor = node as? Enemy {
                meteor.gameOver()
            }
        }
    }
}
