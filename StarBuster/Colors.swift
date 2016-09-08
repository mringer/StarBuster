//
//  Colors.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/2/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class Colors {
    
    //RGB Colors
    class var Background:Int    { return 0x000000 }
    class var Magic:Int         { return 0x04f2de }
    class var Laser:Int         { return 0xff0000 }
    class var FontBonus:Int     { return 0xb3ff01 }
    class var FontScore:Int     { return 0xe6e7e8 }
    class var Border:Int        { return 0x49b9ea }
    
    class func colorFromRGB( rgbValue rgbValue: Int ) -> SKColor {
        return SKColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((rgbValue & 0x00FF00) >> 8 ) / 255.0,
                       blue: CGFloat((rgbValue & 0x0000FF) >> 8 ) / 255.0,
                       alpha: 1.0)
    }
}
