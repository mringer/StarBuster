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
