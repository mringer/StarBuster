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
                    skView.showsPhysics = true // Show physics boundaries around sprites.
                }
                
                skView.ignoresSiblingOrder = false
                let menuScene = MenuScene(size: kViewSize)
                let menuTransition = SKTransition.fade(with: SKColor.black, duration: 0.25)
                skView.presentScene(menuScene, transition: menuTransition)
            }
        }
    }

    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}
