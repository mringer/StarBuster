//
//  LiveDebugLog.swift
//  StarBuster
//
//  Created by Matthew Ringer on 9/17/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

extension UIView {
    public func liveDebugLog(_ message: String) {
        #if !(TARGET_OS_IPHONE)
            let logPath = "/tmp/XcodeLiveRendering.log"
            if !FileManager.default.fileExists(atPath: logPath) {
                FileManager.default.createFile(atPath: logPath, contents: Data(), attributes: nil)
            }
            
            let fileHandle = FileHandle(forWritingAtPath: logPath)
            fileHandle!.seekToEndOfFile()
            
            let date = Date()
            let bundle = Bundle(for: type(of: self))
            let application: AnyObject = bundle.object(forInfoDictionaryKey: "CFBundleName")! as AnyObject
            let data = "\(date) \(application) \(message)\n".data(using: String.Encoding.utf8, allowLossyConversion: true)
            fileHandle!.write(data!)
        #endif
    }
}

extension SKNode {
    func checkPhysics() {
        
        // Create an array of all the nodes with physicsBodies
        var physicsNodes = [SKNode]()
        
        //Get all physics bodies
        enumerateChildNodes(withName: "//.") { node, _ in
            if let _ = node.physicsBody {
                physicsNodes.append(node)
            } else {
                print("\(node.name) does not have a physics body so cannot collide or be involved in contacts.")
            }
        }
        
        //For each node, check it's category against every other node's collion and contctTest bit mask
        for node in physicsNodes {
            let category = node.physicsBody!.categoryBitMask
            // Identify the node by its category if the name is blank
            let name = node.name != nil ? node.name : "Category \(category)"
            let collisionMask = node.physicsBody!.collisionBitMask
            let contactMask = node.physicsBody!.contactTestBitMask
            
            // If all bits of the collisonmask set, just say it collides with everything.
            if collisionMask == UInt32.max {
                print("\(name) collides with everything")
            }
            
            for otherNode in physicsNodes {
                if (node != otherNode) && (node.physicsBody?.isDynamic == true) {
                    let otherCategory = otherNode.physicsBody!.categoryBitMask
                    // Identify the node by its category if the name is blank
                    let otherName = otherNode.name != nil ? otherNode.name : "Category \(otherCategory)"
                    
                    // If the collisonmask and category match, they will collide
                    if ((collisionMask & otherCategory) != 0) && (collisionMask != UInt32.max) {
                        print("\(name) collides with \(otherName)")
                    }
                    // If the contactMAsk and category match, they will contact
                    if (contactMask & otherCategory) != 0 {print("\(name) notifies when contacting \(otherName)")}
                }
            }
        }
    }
}
