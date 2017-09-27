//
//  FaceCircleView.swift
//  WatchFace
//
//  Created by Tony Monckton on 26/08/2017.
//  Copyright © 2017 PsoinicDesign.co.uk. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class FaceCircleView: UIView {
    let circlePathLayer         = CAShapeLayer()
    var circleRadius: CGFloat   = 50.0
    var circleFrame: CGRect!
    var circleScale: CGFloat    = 0.00
    
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let components: [CGFloat] = [0.0, 0.0, 1.0, 1.0]
    
    var optColor: CGColor!

    init(frame: CGRect, scale: CGFloat) {
        super.init(frame: frame)

        configure(frame: frame, scale: scale)
        progress = 0.00
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    // member functions

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(frame: CGRect, scale: CGFloat) {

        let lineWidth:CGFloat   = 20.0
        backgroundColor = .clear

        
        circleScale             = scale;
        circleRadius            = ((frame.width/2)*circleScale)-(lineWidth/2.0)
        circleFrame             = CGRect(x: 0, y: 0, width: circleRadius*2, height: circleRadius*2)

        circlePathLayer.path            = UIBezierPath(ovalIn: circleFrame).cgPath
        circlePathLayer.frame           = circleFrame
        circlePathLayer.anchorPoint     = CGPoint(x: 0.5, y:0.5)
        circlePathLayer.position        = CGPoint(x: frame.width/2, y: frame.height/2)
        circlePathLayer.lineWidth       = lineWidth
        circlePathLayer.fillColor       = UIColor.clear.cgColor
        circlePathLayer.strokeColor     = UIColor.blue.cgColor
        circlePathLayer.lineCap         = "round"
        circlePathLayer.transform       = CATransform3DMakeRotation(4.71239, 0.0, 0.0, 1.0)
        circlePathLayer.backgroundColor = UIColor.clear.cgColor
        
        circlePathLayer.shadowColor     = UIColor.blue.cgColor
        circlePathLayer.shadowRadius    = 15.0
        circlePathLayer.shadowOpacity   = 1.0
        circlePathLayer.masksToBounds   = false

        layer.addSublayer(circlePathLayer)
    }
    
    func options(jsonDict:[String: String]?)
    {
        if jsonDict != nil
        {
            print( jsonDict?["color"] as Any )
        }
    }
    
    private func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func options( json: String)
    {
    
    }
    
    var progress: CGFloat {
        get {
            return circlePathLayer.strokeEnd
        }
        set {
            if newValue > 1 {
                circlePathLayer.strokeEnd = 1
                //circlePathLayer.lineCap = "square"
            } else if newValue < 0 {
                circlePathLayer.strokeEnd = 0
            } else {
                circlePathLayer.strokeEnd = newValue
            }
        }
    }
}
