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

class WatchCircleViewModel: WatchView {
    
    var WatchFrame:CGRect   = CGRect.zero
    var WatchDateTime       = watchDateTime()
    
    var mWatchHandSecond: WatchHand!
    var mWatchHandMinute: WatchHand!
    var mWatchHandHour: WatchHand!

    var secondPathLayer:CAShapeLayer!
    var minutePathLayer:CAShapeLayer!
    var hourPathLayer:CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contruct(frame: frame, options: String())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeCircle( frame: CGRect, scale: CGFloat ) -> CAShapeLayer
    {
        let lineWidth:CGFloat   = 20.0
        let circleScale:CGFloat = scale
        let circleRadius        = ((WatchFrame.width/2)*circleScale)-(lineWidth/2.0)
        let circleFrame:CGRect  = CGRect(x: 0, y: 0, width: circleRadius*2, height: circleRadius*2)
        
        let circlePathLayer         = CAShapeLayer()
        
        circlePathLayer.path            = UIBezierPath(ovalIn: circleFrame).cgPath
        circlePathLayer.frame           = CGRect(x: 0, y: 0, width: circleRadius*2, height: circleRadius*2)
        circlePathLayer.anchorPoint     = CGPoint(x: 0.5, y:0.5)
        circlePathLayer.position        = CGPoint(x: frame.width/2, y: frame.height/2)
        circlePathLayer.lineWidth       = 20.0
        circlePathLayer.fillColor       = UIColor.clear.cgColor
        circlePathLayer.strokeColor     = UIColor.blue.cgColor
        circlePathLayer.lineCap         = "round"
        circlePathLayer.transform       = CATransform3DMakeRotation(4.71239, 0.0, 0.0, 1.0)
        circlePathLayer.backgroundColor = UIColor.clear.cgColor
        
        circlePathLayer.shadowColor     = UIColor.blue.cgColor
        circlePathLayer.shadowRadius    = 15.0
        circlePathLayer.shadowOpacity   = 1.0
        circlePathLayer.masksToBounds   = false
        
        return circlePathLayer
    }
    
    
    override func contruct(frame: CGRect, options: String)
    {
        self.backgroundColor = .clear
        self.name = "Hands face watch"
        
        WatchFrame = frame
        
        secondPathLayer = makeCircle(frame: WatchFrame, scale: 0.90)
        layer.addSublayer(secondPathLayer)

        minutePathLayer = makeCircle(frame: WatchFrame, scale: 0.60)
        layer.addSublayer(minutePathLayer)

        hourPathLayer = makeCircle(frame: WatchFrame, scale: 0.30)
        layer.addSublayer(hourPathLayer)        
    }

    
    override func update()
    {
        WatchDateTime.update()
        secondPathLayer.strokeEnd = WatchDateTime.secondProgress
        minutePathLayer.strokeEnd = WatchDateTime.minuteProgress
        hourPathLayer.strokeEnd = WatchDateTime.hourProgress
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

