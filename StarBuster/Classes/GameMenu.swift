//
//  GameMenu.swift
//  StarBuster
//
//  Created by Matthew Ringer on 9/17/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class GameMenu: UIView {
    
    var view: UIView!
    let nibName = "GameMenu"
    
    override init(frame: CGRect) { // programmer creates our custom View
        super.init(frame: frame)
        self.setupGameMenu()
    }
    
    required init(coder aDecoder: NSCoder) {  // Storyboard or UI File
        super.init(coder: aDecoder)!
        self.setupGameMenu()
    }
    
    func setupGameMenu() { // setup XIB here
        
        view = loadFromNib()
        view.frame = CGRect(x: 0, y: 0, width: 250, height: 100) // this will be the size of the GameMenu
        //view.autoresizingMask = UIViewAutoresizing.FlexibleWidth // | UIViewAutoresizing.FlexibleHeight
        self.addSubview(view)
    }
    
    
    func loadFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        //liveDebugLog(bundle.bundlePath)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    @IBAction func toggleSound(sender: UISwitch, forEvent event: UIEvent) {
                GameAudio.sharedInstance.toggleMuteBackGroundMusic()
    }
    
//    @IBAction func toggleSound(sender: UISwitch, forEvent event: UIEvent) {
//        GameAudio.sharedInstance.pausedBackgroundMusic()
//    }
//    @IBAction func toggleSound(sender: AnyObject) {
//        GameAudio.sharedInstance.pausedBackgroundMusic()
//    }
}