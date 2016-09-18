//
//  main.swift
//  StarBuster
//
//  Created by Matthew Ringer on 9/17/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import UIKit
    
let isRunningTests = NSClassFromString("XCTestCase") != nil
let appDelegateClass: AnyClass = isRunningTests ? TestingAppDelegate.self : AppDelegate.self
    
UIApplicationMain(Process.argc, UnsafeMutablePointer<UnsafeMutablePointer<CChar>>(Process.unsafeArgv), nil, NSStringFromClass(appDelegateClass))