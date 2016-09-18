//
//  GameMenuActions.swift
//  StarBuster
//
//  Created by Matthew Ringer on 9/17/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import UIKit

class GameMenuActions: UIView {
    

    @IBAction func toggleSound(sender: AnyObject) {
            GameAudio.sharedInstance.pausedBackgroundMusic()
    }

}