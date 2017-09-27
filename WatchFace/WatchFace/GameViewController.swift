//
//  GameViewController.swift
//  WatchFace
//
//  Created by Tony Monckton on 23/08/2017.
//  Copyright © 2017 PsoinicDesign.co.uk. All rights reserved.
//

import UIKit
import SpriteKit
import QuartzCore

class GameViewController: UIViewController {
    
//    var myWatchViewModel: WatchCircleViewModel!
//    var myWatchViewModels   = [WatchView]()
    var myWatchManager: watchManager!     = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        myWatchManager = watchManager(frame:UIScreen.main.bounds)
        self.view.addSubview(myWatchManager)
        
        // gestures
/*
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
*/        
        
        // gameloop
        let updater = CADisplayLink(target: self, selector: #selector(self.gameLoop))
        updater.preferredFramesPerSecond = 60
        updater.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        
    }
/*
    static func scrollToPage(scrollView: UIScrollView, page: Int, animated: Bool) {
        var frame: CGRect = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page);
        frame.origin.y = 0;
        scrollView.scrollRectToVisible(frame, animated: animated)
    }
*/

/*
    func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
*/
    
    func gameLoop()
    {
        myWatchManager.update()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
        print("menory Warning")
    }

}
