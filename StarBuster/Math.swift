//
//  Math.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/2/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

func Smooth(startPoint: CGFloat, endPoint: CGFloat, filter: CGFloat ) -> CGFloat {
    return (startPoint * (1 - filter)) + endPoint * filter
}

func RandomIntegerBetween(min: Int, max: Int ) -> Int {
    return Int(UInt32(min) + arc4random_uniform(UInt32(max - min + 1)))
}

func RandomFloatRange(min: CGFloat, max: CGFloat) -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
}

func DegreesToRadians(degrees: CGFloat) -> CGFloat {
    return degrees * CGFloat(M_PI) / 180
}
