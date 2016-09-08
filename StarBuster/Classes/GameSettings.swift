//
//  GameSettings.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/10/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import Foundation

let GameSettingsSharedInstance = GameSettings()

class GameSettings {
    
    class var sharedInstance:GameSettings {
        return GameSettingsSharedInstance
    }
    
    // MARK: - Private Class Constants
    let localDefaults = NSUserDefaults.standardUserDefaults()
    private let keyFirstRun = "FirstRun"
    private let keyBestScore = "BestScore"
    private let keyBestStars = "BestStars"
    private let keyBestStreak = "BestStreak"
    
    
    // MARK: - Init
    init() {
        if self.localDefaults.objectForKey(keyFirstRun) == nil {
            self.firstLaunch()
        }
    }
    
    // MARK: - Private functions
    private func firstLaunch() {
        self.localDefaults.setInteger(0, forKey: keyBestScore)
        self.localDefaults.setBool(false, forKey: keyFirstRun)
        self.localDefaults.setInteger(0, forKey: keyBestStars)
        self.localDefaults.setInteger(0, forKey: keyBestStreak)
        self.localDefaults.synchronize()
    }
    
    // MARK: - Public saving functions
    func saveBestScore(score score:Int) {
        self.localDefaults.setInteger(score, forKey: keyBestScore)
        self.localDefaults.synchronize()
    }
    
    func saveBestStars(stars stars:Int) {
        self.localDefaults.setInteger(stars, forKey: keyBestStars)
        self.localDefaults.synchronize()
    }
    
    func saveBestStreak(streak streak:Int) {
        self.localDefaults.setInteger(streak, forKey: keyBestStreak)
        self.localDefaults.synchronize()
    }
    
    func getBestScore() -> Int {
        return self.localDefaults.integerForKey(keyBestScore)
    }
    
    func getBestStars() -> Int {
        return self.localDefaults.integerForKey(keyBestStars)
    }
    
    
    func getBestStreak() -> Int {
        return self.localDefaults.integerForKey(keyBestStreak)
    }
    
    
}