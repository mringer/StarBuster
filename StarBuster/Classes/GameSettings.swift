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
    let localDefaults = UserDefaults.standard
    fileprivate let keyFirstRun = "FirstRun"
    fileprivate let keyBestScore = "BestScore"
    fileprivate let keyBestStars = "BestStars"
    fileprivate let keyBestStreak = "BestStreak"
    fileprivate let keySoundOn = "SoundOn"
    
    
    // MARK: - Init
    init() {
        if self.localDefaults.object(forKey: keyFirstRun) == nil {
            self.firstLaunch()
        }
    }
    
    // MARK: - Private functions
    fileprivate func firstLaunch() {
        self.localDefaults.set(0, forKey: keyBestScore)
        self.localDefaults.set(false, forKey: keyFirstRun)
        self.localDefaults.set(0, forKey: keyBestStars)
        self.localDefaults.set(0, forKey: keyBestStreak)
        self.localDefaults.set(false, forKey: keySoundOn)
        self.localDefaults.synchronize()
    }
    
    // MARK: - Public saving functions
    func saveBestScore(score:Int) {
        self.localDefaults.set(score, forKey: keyBestScore)
        self.localDefaults.synchronize()
    }
    
    func saveBestStars(stars:Int) {
        self.localDefaults.set(stars, forKey: keyBestStars)
        self.localDefaults.synchronize()
    }
    
    func saveBestStreak(streak:Int) {
        self.localDefaults.set(streak, forKey: keyBestStreak)
        self.localDefaults.synchronize()
    }
    
    func saveSoundOn(on:Bool) {
        self.localDefaults.set(on, forKey: keySoundOn)
        self.localDefaults.synchronize()
    }
    
    func getBestScore() -> Int {
        return self.localDefaults.integer(forKey: keyBestScore)
    }
    
    func getBestStars() -> Int {
        return self.localDefaults.integer(forKey: keyBestStars)
    }
    
    
    func getBestStreak() -> Int {
        return self.localDefaults.integer(forKey: keyBestStreak)
    }
    
    func getSoundOn() -> Bool {
        return self.localDefaults.bool(forKey: keySoundOn)
    }
    
}
