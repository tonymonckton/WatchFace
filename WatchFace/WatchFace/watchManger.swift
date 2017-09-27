//
//  watch.swift
//  WatchFace
//
//  Created by Tony Monckton on 28/08/2017.
//  Copyright © 2017 We Create! digital design. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

extension UIView {
    
    func fadeIn(duration: TimeInterval = 2.0, delay: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }

    func fadeOut(duration: TimeInterval = 2.0, delay: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
    
    func isVisable() -> Bool {
        if (self.alpha > 0.95 ) {  return true }
        else {  return false }
    }
}

class watchManager: UIView, UIScrollViewDelegate
{
    var watchFrame:CGRect   = CGRect.zero
    var myWatchViewModels   = [WatchView]()
    var myCurrentViewModel  = 0
    var myWatchDateTime     = watchDateTime()
    
    var scrollView  = UIScrollView()
    var pageControl: UIPageControl!
    var fadeTimer       = Timer()
    
//    var myWatchCircle: WatchCircleViewModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.watchFrame = frame
        
        contruct(frame: frame, options: "")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func contruct(frame: CGRect, options: String)
    {
        var myFrame = frame

        // create faces
        myFrame.origin.x = myFrame.width*0
        let myWatchHands = WatchHandsViewModel(frame:myFrame )
        myWatchHands.options(json:"{'color': 'red', 'glow': 'true'}")
        myWatchViewModels.append(myWatchHands)

        myFrame.origin.x = myFrame.width*1.0
        let myWatchHCircle = WatchCircleViewModel(frame:myFrame)
        myWatchHCircle.options(json:"{'color': 'red', 'glow': 'true'}")
        myWatchViewModels.append(myWatchHCircle)
        
        // create scrollview
        scrollView                  = UIScrollView()
        scrollView.delegate         = self
        scrollView.bounces          = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.isPagingEnabled  = true
        scrollView.contentSize      = CGSize(width:frame.width*CGFloat(myWatchViewModels.count), height:frame.height)
        scrollView.frame            = frame

        // add faces to scrollview
        scrollView.addSubview(myWatchHands)
        scrollView.addSubview(myWatchHCircle)

        configurePageControl( aframe: frame, total: myWatchViewModels.count )
        
        self.addSubview(scrollView)
        
        fadeTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: false)
    }

    func timerAction() {
        pageControl.fadeOut(duration: 3.0, delay: 1.0)
        print ("fadeOut")
    }
    
    func configurePageControl( aframe: CGRect, total: Int) {
        pageControl = UIPageControl(frame: CGRect(x:0,y:aframe.width/2.0, width:aframe.width, height:aframe.height))
        pageControl.numberOfPages           = total
        pageControl.currentPage             = 0
        pageControl.tintColor               = UIColor.gray
        pageControl.pageIndicatorTintColor  = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
        self.addSubview(pageControl)
        pageControl.fadeOut(duration:0.0)
        pageControl.fadeIn(duration: 3.0, delay: 1.0)
    }
    
    
    
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
        print("changePage:", pageControl.currentPage)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if ( pageControl != nil )
        {
            let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            pageControl.currentPage = Int(pageNumber)
            
            
            print (self.alpha)
            print (self.isVisable())
//            if ( self.isVisable() == false )  {
                pageControl.fadeIn(duration: 1.0, delay: 0.0)
                fadeTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: false)
//            }
            
            print("scrollViewDidEndDecelerating page:",pageNumber)
        }
    }
        
    
    func update() {
        for watchVM in myWatchViewModels
        {
            watchVM.update()
        }
    }
    
    func destruct()
    {}
}

