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
    
    @IBOutlet weak var SoundOnSwitch: UISwitch!
    
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
        
        SoundOnSwitch.setOn(GameAudio.sharedInstance.isSoundOn, animated: false)
    }
    
    
    func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        //liveDebugLog(bundle.bundlePath)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    @IBAction func toggleSound(_ sender: UISwitch, forEvent event: UIEvent) {
                // if button not isOn mute should be true
                GameAudio.sharedInstance.setSoundOn(sender.isOn)
    }
}
