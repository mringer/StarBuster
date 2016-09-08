//
//  GameViewController.swift
//  StarBuster
//
//  Created by Matthew Ringer on 7/22/16.
//  Copyright (c) 2016 Matthew Ringer. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        if let skView = self.view as? SKView {
            if (skView.scene == nil){
                if kDebug{
                    skView.showsFPS = true
                }
                // Show physics boundaries around sprites.
                skView.showsPhysics = true
                skView.ignoresSiblingOrder = true
                let menuScene = MenuScene(size: kViewSize)
                let menuTransition = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 0.25)
                skView.presentScene(menuScene, transition: menuTransition)
            }
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
