//
//  GameAudio.swift
//  StarBuster
//
//  Created by Matthew Ringer on 9/9/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit
import AVFoundation

class Music {
    class var Game:String { return "GameMusic.mp3" }
}

extension SKSpriteNode {
    // MARK: - Sound Effects
    func playSoundEffect(_ soundEffect:GameAudio.SoundEffect) {
        if(GameAudio.sharedInstance.isSoundOn){
            self.run(GameAudio.sharedInstance.getSoundEffect(name: soundEffect))
        }
    }
}

private class SoundEffects {
    // Shields
    class var ShieldUp:String   { return "ShieldUp.caf" }
    class var ShieldDown:String { return "ShieldDown.caf" }
    // Interface
    class var ButtonTap:String  { return "ButtonTap.caf" }
    class var Explosion:String  { return "Explosion.caf" }
    //Scoring
    class var Pickup:String     { return "Pickup.caf" }
}

let GameAudioSharedInstance = GameAudio()

class GameAudio {
    
    class var sharedInstance:GameAudio {
        
        do {
            // Audio Plays with other sources, and mutes on silent switch.
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategorySoloAmbient)
        } catch {
            if kDebug{
                print(error)
            }
        }
        return GameAudioSharedInstance
    }
    
    // MARK: - Private class variables
    fileprivate var musicPlayer = AVAudioPlayer()
    fileprivate var backroundMusic:String = Music.Game
    fileprivate var soundOn = true;
    fileprivate var initialized = false
    
    // MARK: - class constants
    fileprivate let soundShieldUp = SKAction.playSoundFileNamed(SoundEffects.ShieldUp, waitForCompletion: false)
    fileprivate let soundShieldDown = SKAction.playSoundFileNamed(SoundEffects.ShieldDown, waitForCompletion: false)
    fileprivate let soundButtonTap = SKAction.playSoundFileNamed(SoundEffects.ButtonTap, waitForCompletion: false)
    fileprivate let soundExplosion = SKAction.playSoundFileNamed(SoundEffects.Explosion, waitForCompletion: false)
    fileprivate let soundPickup = SKAction.playSoundFileNamed(SoundEffects.Pickup, waitForCompletion: false)
    
    // MARK: - Public class variables
    enum SoundEffect {
        case ShieldUp
        case ShieldDown
        case ButtonTap
        case Explosion
        case Pickup
    }
    
    var isSoundOn:Bool {
        get {return soundOn}
    }
    
    fileprivate init() {
        self.soundOn = GameSettings.sharedInstance.getSoundOn()
    }
    
    // MARK: - Music Player
    func playBackgroundMusic(fileName:String) {
        
        if(!self.soundOn) { // if the sound is off don't set up the audio player
            return
        }
        
        self.backroundMusic = fileName
        let music = URL(fileURLWithPath: Bundle.main.path(forResource: fileName, ofType: nil)!)
        
        do {
            self.musicPlayer = try AVAudioPlayer(contentsOf: music)
        } catch let error as NSError {
            if kDebug {
                print(error)
            }
        }
        
        self.musicPlayer.numberOfLoops = -1
        self.musicPlayer.volume = 0.25
        self.musicPlayer.prepareToPlay()
        self.musicPlayer.play()
        
        self.initialized = true
    }
    
    fileprivate func getSoundEffect(name:SoundEffect) -> SKAction {
        
        switch name {
        case SoundEffect.ShieldUp:
            return self.soundShieldUp
        case SoundEffect.ShieldDown:
            return self.soundShieldDown
        case SoundEffect.ButtonTap:
            return self.soundButtonTap
        case SoundEffect.Explosion:
            return self.soundExplosion
        case SoundEffect.Pickup:
            return self.soundPickup
        }
        
    }
    
    func setSoundOn(_ on:Bool) {
        self.soundOn = on
        GameSettings.sharedInstance.saveSoundOn(on: on)
        if(on) {
            resumeBackgroundMusic()
        } else {
            pausedBackgroundMusic()
        }
    }
    
    func stopBackgroundMusic() {
        if self.initialized && self.musicPlayer.isPlaying {
            self.musicPlayer.stop()
        }
    }
    
    func pausedBackgroundMusic() {
        if self.initialized && self.musicPlayer.isPlaying {
            self.musicPlayer.pause()
        }
    }
    
    func resumeBackgroundMusic() {
        if self.initialized && self.soundOn {
            self.musicPlayer.play()
        } else {
            self.playBackgroundMusic(fileName: self.backroundMusic)
        }
    }
}
