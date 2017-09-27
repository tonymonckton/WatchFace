//
//  WatchFaceView.swift
//  WatchFace
//
//  Created by Tony Monckton on 23/08/2017.
//  Copyright © 2017 PsoinicDesign.co.uk. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore


class WatchHand {
    
    var mHandPath: UIBezierPath!
    var mHandLayer: CAShapeLayer!
    var mHandRadius: CGFloat   = 1.0

    init(frame: CGRect, scale: CGFloat, lineWidth: CGFloat ) {

        mHandRadius            = ((frame.width/2)*scale)
        
        mHandPath = UIBezierPath()
        
        mHandPath.move( to: CGPoint(x: -1.0, y: 0.0) )
        mHandPath.addLine(to: CGPoint(x: 0, y: -mHandRadius))
        mHandPath.addLine(to: CGPoint(x: 1.0, y: 0.0))
        mHandPath.addLine(to: CGPoint(x: -1.0, y: 0.0))
        mHandPath.close()
       
        mHandLayer = CAShapeLayer()
        mHandLayer.lineJoin        = kCALineJoinRound
        mHandLayer.path            = mHandPath.cgPath
        mHandLayer.anchorPoint     = CGPoint(x: 0.0, y:0.0)
        mHandLayer.position        = CGPoint(x: frame.width/2.0, y: frame.height/2.0)
        mHandLayer.transform        = CATransform3DMakeRotation(0.0, 0.0, 0.0, 1.0)
        mHandLayer.lineWidth       = lineWidth
        mHandLayer.fillColor       = UIColor.white.cgColor
        mHandLayer.strokeColor     = UIColor.white.cgColor
        mHandLayer.backgroundColor = UIColor.clear.cgColor
        mHandLayer.lineCap         = "round"
        mHandLayer.masksToBounds   = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update( progress: CGFloat)
    {
        mHandLayer.transform  = CATransform3DMakeRotation(6.28319*progress, 0.0, 0.0, 1.0)
    }
    
    var handLayer: CALayer {
        get {   return mHandLayer   }
    }
}

class WatchHandsViewModel: WatchView {
    
    var WatchFrame:CGRect   = CGRect.zero
    var WatchDateTime       = watchDateTime()
    
    var mWatchHandSecond: WatchHand!
    var mWatchHandMinute: WatchHand!
    var mWatchHandHour: WatchHand!
    var mWatchSpindle: CAShapeLayer!
    var mWatchDial: CAShapeLayer!

    var circlePathLayer:CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        print("h self.frame x:", self.frame.origin.x)
        print("h self.frame y:", self.frame.origin.y)
        print("h self.frame w:", self.frame.width)
        print("h self.frame h:", self.frame.height)
        
        contruct(frame: frame, options: String())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func contruct(frame: CGRect, options: String)
    {
        self.backgroundColor = .clear
        self.name = "Hands face watch"
        
        WatchFrame = frame

        //drawText(aframe: WatchFrame, aText: "hello world")
        
        
//        battery()
//        drawBattery( faceframe: WatchFrame, aBatLevel: 0.75 )
        
        for i in stride(from: 30, to: 390, by: 30)
        {
            drawText( aframe: WatchFrame, aAngle: CGFloat(i), aText: String(i/30))
        }
//        drawText( aframe: WatchFrame, aAngle: 90.0, aText: "3")
//    drawText( aframe: WatchFrame, aAngle: 180.0, aText: "6")
//        drawText( aframe: WatchFrame, aAngle: 270.0, aText: "9")
        
        mWatchHandSecond = WatchHand( frame: WatchFrame, scale: 0.815, lineWidth: 0.75 )
        layer.addSublayer(mWatchHandSecond.handLayer)

        mWatchHandMinute = WatchHand( frame: WatchFrame, scale: 0.55, lineWidth: 1.5 )
        layer.addSublayer(mWatchHandMinute.handLayer)

        mWatchHandHour = WatchHand( frame: WatchFrame, scale: 0.40, lineWidth: 2.25 )
        layer.addSublayer(mWatchHandHour.handLayer)
        
        mWatchSpindle = makeSpindle( aframe: WatchFrame )
        layer.addSublayer(mWatchSpindle)
        
//        mWatchDial = makeDial( aframe: WatchFrame)
//        layer.addSublayer(mWatchDial)
        
        for i in stride(from: 0, to: 360, by: 30)
        {
            layer.addSublayer(makeHours( aframe: WatchFrame, angle: CGFloat(i), length: 20.0, lineWidth: 1.5, scale: 0.90 ))
        }
        
        for i in stride(from: 0, to: 360, by: 6)
        {
            if i%30 != 0
            {
                layer.addSublayer(makeHours( aframe: WatchFrame, angle: CGFloat(i), length: 7.0, lineWidth: 0.75, scale: 0.815 ))
            }
        }
        
    }

    func makeSpindle( aframe: CGRect) -> CAShapeLayer
    {
        var cBezierPath: UIBezierPath!
        var cLayer: CAShapeLayer!
        let cRadius: CGFloat   = 4.0
        
        cBezierPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: cRadius, height: cRadius), cornerRadius: cRadius)
        
        cLayer = CAShapeLayer()
        cLayer.path             = cBezierPath.cgPath
        cLayer.anchorPoint      = CGPoint(x: 0.5, y:0.5)
        cLayer.position         = CGPoint(x: aframe.width/2.0 - cRadius/2.0, y: aframe.height/2.0 - cRadius/2.0)
        cLayer.fillColor        = UIColor.white.cgColor
        cLayer.backgroundColor  = UIColor.clear.cgColor
        cLayer.masksToBounds   = false

        return cLayer
    }

    
    func makeDial( aframe: CGRect) -> CAShapeLayer
    {
        var cBezierPath: UIBezierPath!
        var cLayer: CAShapeLayer!
        let cScale: CGFloat     = 0.90
        let cRadius: CGFloat   = (aframe.width/2.0)*cScale
        
        cBezierPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: aframe.width*cScale, height: aframe.width*cScale), cornerRadius: cRadius)
        
        cLayer = CAShapeLayer()
        cLayer.path             = cBezierPath.cgPath
        cLayer.anchorPoint      = CGPoint(x: 0.0, y:0.0)
        cLayer.position         = CGPoint(x: aframe.width/2.0 - cRadius, y: aframe.height/2.0 - cRadius)
        cLayer.lineWidth        = 0.75
        cLayer.fillColor        = UIColor.clear.cgColor
        cLayer.strokeColor      = UIColor.white.cgColor
        cLayer.backgroundColor  = UIColor.clear.cgColor
        cLayer.masksToBounds    = false
        
        return cLayer
    }
    
    func makeHours(aframe: CGRect, angle: CGFloat, length: CGFloat, lineWidth: CGFloat, scale: CGFloat) -> CAShapeLayer
    {
        let aPath               = UIBezierPath()
        let cScale: CGFloat     = scale
        let cRadius: CGFloat    = (aframe.width/2.0)*cScale
        let cLength: CGFloat    = length
        
        aPath.move( to: CGPoint(x: -cRadius, y: 0.0) )
        aPath.addLine(to: CGPoint(x: -cRadius + cLength, y: 0.0))

        let cLayer = CAShapeLayer()
        cLayer.path             = aPath.cgPath
        cLayer.anchorPoint      = CGPoint(x: 0.0, y:0.0)
        cLayer.lineJoin         = kCALineJoinRound
        cLayer.position         = CGPoint(x: (aframe.width/2.0), y: aframe.height/2.0)
        cLayer.transform        = CATransform3DMakeRotation(angle.degreesToRadians(), 0.0, 0.0, 1.0)
        cLayer.lineWidth        = lineWidth
        cLayer.lineCap          = "round"
        cLayer.strokeColor      = UIColor.white.cgColor
        cLayer.masksToBounds    = false
        
        return cLayer
    }
    
    func drawText( aframe: CGRect, aAngle: CGFloat, aText: String)
    {
        let aTextLayer      = CATextLayer()
        let aTextFrame      = CGRect( x:0.0, y:0.0, width: aframe.width*0.40, height: aframe.height*0.40)
       // let angle:CGFloat    = 90.0
//        drawFrame( aframe: aTextFrame )
//        drawFrame( aframe: aframe )
        
        
        aTextLayer.frame        = aTextFrame
        aTextLayer.position     = CGPoint( x: aframe.width/2.0, y: aframe.height/2.0)
        aTextLayer.anchorPoint  = CGPoint( x: 0.5, y: 0.5 )
        aTextLayer.transform    = CATransform3DMakeRotation(aAngle.degreesToRadians(), 0.0, 0.0, 1.0)
        aTextLayer.string       = aText
        aTextLayer.font         = CTFontCreateWithName("helvatica" as CFString?, 6, nil)
        aTextLayer.fontSize     = 12.0
        aTextLayer.alignmentMode = kCAAlignmentCenter
        
        layer.addSublayer(aTextLayer)
    }
    
    func drawFrame( aframe: CGRect)
    {
        let aLayer              = CAShapeLayer()
        let aPath               = UIBezierPath(roundedRect: aframe, cornerRadius: 0.0)
        
        aLayer.path             = aPath.cgPath
        aLayer.frame            = aframe
        aLayer.position         = CGPoint(x: aframe.origin.x, y: aframe.origin.y)
        aLayer.anchorPoint      = CGPoint(x: 0.0, y:0.0)
        aLayer.lineWidth        = 1.0
        aLayer.masksToBounds    = false
        aLayer.strokeColor      = UIColor.white.cgColor
        aLayer.fillColor        = UIColor.clear.cgColor
        aLayer.backgroundColor  = UIColor.clear.cgColor

        layer.addSublayer(aLayer)
    }
    
    func drawBattery( faceframe: CGRect , aBatLevel: Float = 0.5)
    {
        let aXPos:CGPoint       = CGPoint(x:0.0,y:0.0)
        let aFrame:CGRect       = faceframe

        let aScale:CGFloat      = 1.0
        let aSize:CGPoint       = CGPoint(x:20.0,y:10.0)
        let aSize2:CGPoint      = CGPoint(x:1.75,y:4.0)

        let parentLayer:CALayer      = CALayer()
        parentLayer.position         = CGPoint(x: 150.0, y: 170.0)
        
        // level
        let aLayer              = CAShapeLayer()
        let aRect               = CGRect(x: 0, y: 0, width: (aSize.x*CGFloat(aBatLevel))*aScale, height: aSize.y*aScale)
        let aPath               = UIBezierPath(roundedRect: aRect, cornerRadius: 1.0)
        
        aLayer.path             = aPath.cgPath
        aLayer.frame            = aRect
        aLayer.position         = CGPoint(x: aFrame.origin.x, y: aFrame.origin.y)
        aLayer.anchorPoint      = CGPoint(x: 0.0, y:0.0)
//        aLayer.anchorPoint      = CGPoint(x: 0.5, y:0.5)
//        aLayer.transform        = CATransform3DMakeRotation(CGFloat(45.0).degreesToRadians(), 0.0, 0.0, 1.0)
        aLayer.lineWidth        = 1.0*aScale
        aLayer.masksToBounds    = false
        aLayer.strokeColor      = UIColor.clear.cgColor
        aLayer.fillColor        = UIColor.white.cgColor
        aLayer.backgroundColor  = UIColor.clear.cgColor
        parentLayer.addSublayer(aLayer)

        // bat body
        let aLayer1              = CAShapeLayer()
        let aRect1               = CGRect(x: 0, y: 0, width: aSize.x*aScale, height: aSize.y*aScale)
        let aPath1               = UIBezierPath(roundedRect: aRect1, cornerRadius: 2.5*aScale)
        aLayer1.path             = aPath1.cgPath
        aLayer1.frame            = aRect1
        aLayer1.anchorPoint      = CGPoint(x: 0.0, y:0.0)
        aLayer1.position         = aXPos
        aLayer1.lineWidth        = 1.0*aScale
        aLayer1.masksToBounds    = false
        aLayer1.strokeColor      = UIColor.white.cgColor
        aLayer1.fillColor        = UIColor.clear.cgColor
        aLayer1.backgroundColor  = UIColor.clear.cgColor
        parentLayer.addSublayer(aLayer1)

        // cap
        let aRect2:CGRect        = CGRect(x: 0, y: 0, width: aSize2.x*aScale, height: aSize2.y*aScale)
        let aPath2               = UIBezierPath(roundedRect: aRect2, cornerRadius: 2.5*aScale)
        let cLayer2              = CAShapeLayer()
        cLayer2.path             = aPath2.cgPath
        cLayer2.frame            = aRect2
        cLayer2.anchorPoint      = CGPoint(x: 0.0, y:0.0)
        cLayer2.position         = CGPoint(x: aXPos.x+(aSize.x*aScale), y: (aSize.y*aScale)/2.0 - (aSize2.y*aScale)/2.0)
//        cLayer2.position         = CGPoint(x: 0.0, y: aXPos.y)
        cLayer2.lineWidth        = 1.0*aScale
        cLayer2.strokeColor      = UIColor.clear.cgColor
        cLayer2.fillColor        = UIColor.white.cgColor
        cLayer2.backgroundColor  = UIColor.clear.cgColor
        parentLayer.addSublayer(cLayer2)
        

/*
        // half circle
        let cLayer2              = CAShapeLayer()
        let cRect2:CGRect        = CGRect(x: 0, y: 0, width: aSize2.x*aScale, height: aSize2.y*aScale)
        cLayer2.frame            = cRect2
        cLayer2.path             = UIBezierPath(ovalIn: cRect2).cgPath
        cLayer2.transform        = CATransform3DMakeRotation(CGFloat(270.0).degreesToRadians(), 0.0, 0.0, 1.0)
        cLayer2.position         = CGPoint(x: aXPos.x+(aSize.x*aScale)/2.0, y: aXPos.y)
        cLayer2.anchorPoint      = CGPoint(x: 0.5, y:0.5)
        cLayer2.lineWidth        = 1.0*aScale
        cLayer2.strokeStart      = 0.0
        cLayer2.strokeEnd        = 0.5
        cLayer2.strokeColor      = UIColor.white.cgColor
        cLayer2.fillColor        = UIColor.clear.cgColor
        cLayer2.backgroundColor  = UIColor.clear.cgColor
        cLayer2.masksToBounds    = false
        aLayer.addSublayer(cLayer2)
*/
        layer.addSublayer(parentLayer)
    }
    
    func battery()
    {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = UIDevice.current.batteryLevel
        let batteryState = UIDevice.current.batteryState
        
        switch batteryState
        {
        case .unknown:   //  "The battery state for the device cannot be determined."
            print("batteryState: unknown")
            break
        case .unplugged: //  "The device is not plugged into power; the battery is discharging"
            print("batteryState: unplugged")
            break
        case .charging:  //  "The device is plugged into power and the battery is less than 100% charged."
            print("batteryState: charging")
            break
        case .full:      //   "The device is plugged into power and the battery is 100% charged."
            print("batteryState: full")
            break
        }
        print("battery: \(batteryLevel)")
        
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange), name: .UIDeviceBatteryLevelDidChange, object: nil)
    }

    func batteryLevelDidChange(_ notification: Notification) {
        let batteryLevel = UIDevice.current.batteryLevel
        print(batteryLevel)
    }
    
    
    func animateCircles( duration: TimeInterval)
    {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        //circleLayer.strokeEnd = 1.0
        //circleLayer.addAnimation(animation, forKey: "animateCircle")
    }
    
    override func update()
    {
        WatchDateTime.update()
        mWatchHandSecond.update( progress: WatchDateTime.secondProgress )
        mWatchHandMinute.update( progress: WatchDateTime.minuteProgress )
        mWatchHandHour.update( progress: WatchDateTime.hourProgress )
    }
    
    func convertToDictionaryString(text: String) -> [String: String]? {
        guard let data = text.data(using: .utf8) else { return nil }
        let anyResult = try? JSONSerialization.jsonObject(with: data, options: [])
        return anyResult as? [String: String]
    }

    override func options(json:String)
    {
        let json2       = json.replacingOccurrences(of: "'", with: "\"")
        var jsonDict    = convertToDictionaryString(text:json2)
        
        if jsonDict != nil
        {
            //            FaceCircleSecondView.options(jsonDict)
            //            FaceCircleMinuetView.options(jsonDict)
            //            FaceCircleHourView.options(jsonDict)
            
            print( jsonDict?["color"] as Any )
            print( jsonDict?["glow"] as Any  )
        }
    }
    


}

