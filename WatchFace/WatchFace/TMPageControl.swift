//
//  TMPageControl.swift
//  WatchFace
//
//  Created by Tony Monckton on 27/09/2017.
//  Copyright © 2017 PsoinicDesign.co.uk. All rights reserved.
//

import Foundation
import UIKit

class pageControl: UIView
{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, options: String) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func contruct(frame: CGRect, options: String)
    {
        
    }
    
    func options(json:String)  {}
    func update()   {}
    func destruct() {}
    
    func next()
    {
    
    }
    
    func previous()
    {
    }
    
}
