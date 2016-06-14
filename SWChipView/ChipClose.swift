//
//  ChipClose.swift
//  SWChipView
//
//  Created by kunal Chavan on 6/14/16.
//  Copyright © 2016 kunal chavhan. All rights reserved.
//

import UIKit

internal class ChipClose: UIButton {
    
    var iconSize: CGFloat = 10
    var lineWidth: CGFloat = 1
    var lineColor: UIColor = UIColor.whiteColor().colorWithAlphaComponent(0.54)
    
    weak var chipView: ChipView?
    
    override func drawRect(rect: CGRect) {
        let buttonPath = UIBezierPath()
        
        buttonPath.lineWidth = lineWidth
        buttonPath.lineCapStyle = .Round
        
        let iconFrame = CGRect(
            x: (rect.width - iconSize) / 2.0,
            y: (rect.height - iconSize) / 2.0,
            width: iconSize,
            height: iconSize
        )
        
        buttonPath.moveToPoint(iconFrame.origin)
        buttonPath.addLineToPoint(CGPoint(x: iconFrame.maxX, y: iconFrame.maxY))
        buttonPath.moveToPoint(CGPoint(x: iconFrame.maxX, y: iconFrame.minY))
        buttonPath.addLineToPoint(CGPoint(x: iconFrame.minX, y: iconFrame.maxY))
        
        lineColor.setStroke()
        
        buttonPath.stroke()
    }
    
}

