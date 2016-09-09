//
//  Constants.swift
//  StarBuster
//
//  Created by Matthew Ringer on 7/22/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import Foundation
import SpriteKit

//MARK: - DEBUG
let kDebug = true

//MARK: - Screen dimension convenience
let kViewSize = UIScreen.mainScreen().bounds.size
let kScreenCenter = CGPoint(x: kViewSize.width / 2, y: kViewSize.height / 2 )

//MARK: - Device size convenience 
let kDeviceTablet = (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad)

// MARK: - Sprite Names
class SpriteName {
    
    // Button Sprite Names
    class var ButtonPlay:String     { return "PlayButton" }
    class var ButtonStart:String    { return "StartButton" }
    class var ButtonRetry:String    { return "RetryButton" }
    
    // Interface Names
    class var TitleGame:String      { return "GameTitle" }
    class var TitleGameShip:String  { return "GameTitleShip" }
    class var TitleGamePlanet:String  { return "GameTitlePlanet" }
    class var TitleGameOver:String  { return "GameOverTitle" }
    
    // Player
    class var Player:String         { return "Player" }
    class var TouchCircle:String    { return "TouchCircle" }
    
    // Magic
    class var Magic:String          { return "Magic" }
    
    // Meteors
    class var MeteorHuge:String     { return "MeteorHuge" }
    class var MeteorLarge:String    { return "MeteorLarge" }
    class var MeteorMedium:String   { return "MeteorMedium" }
    class var MeteorSmall:String    { return "MeteorSmall" }
    
    // Status Bar
    class var PlayerLives:String    { return "PlayerLives" }
    
    // Stars
    class var Star:String           { return "Star" }
    class var StarIcon:String       { return "StarIcon" }
    
    // Weapons
    class var WeaponLaser:String    { return "WeaponLaser" }
    
    // Labels
    class var LivesLabel:String     { return "LivesLabel" }
    
    // Enemies 
    class var EnemyCruiser:String   { return "EnemyCruiser" }
    class var EnemyDiveBomber:String     { return "EnemyDiveBomber" }
    
}

class Contact {
    class var Scene:UInt32          { return 1 << 0 }
    class var Meteor:UInt32         { return 1 << 1 }
    class var Bonus:UInt32          { return 1 << 2 }
    class var Player:UInt32         { return 1 << 3 }
    class var Weapon:UInt32         { return 1 << 4 }
    class var Enemy:UInt32          { return 1 << 5 }
    class var EnemyWeapon:UInt32    { return 1 << 6 }
    class var Sheild:UInt32         { return 1 << 7 }
    
}
