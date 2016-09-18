//
//  LiveDebugLog.swift
//  StarBuster
//
//  Created by Matthew Ringer on 9/17/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    public func liveDebugLog(message: String) {
        #if !(TARGET_OS_IPHONE)
            let logPath = "/tmp/XcodeLiveRendering.log"
            if !NSFileManager.defaultManager().fileExistsAtPath(logPath) {
                NSFileManager.defaultManager().createFileAtPath(logPath, contents: NSData(), attributes: nil)
            }
            
            let fileHandle = NSFileHandle(forWritingAtPath: logPath)
            fileHandle!.seekToEndOfFile()
            
            let date = NSDate()
            let bundle = NSBundle(forClass: self.dynamicType)
            let application: AnyObject = bundle.objectForInfoDictionaryKey("CFBundleName")!
            let data = "\(date) \(application) \(message)\n".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            fileHandle!.writeData(data!)
        #endif
    }
}