//
//  BubbleView.swift
//  TinkoffChat
//
//  Created by MacBookPro on 11/03/2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import UIKit

class BubbleView: UIView {

    var isIncoming = true {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        //fill canvas
        UIColor.white.setFill()
        UIRectFill(rect)
        
        // main body
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: rect.minX, y: rect.minY, width: rect.maxX, height: rect.maxY - 10.0), cornerRadius: 10.0)
        
        // tail
        if isIncoming {
            bezierPath.move(to: CGPoint(x: rect.minX + 30.0, y: rect.maxY - 10.0))
            bezierPath.addLine(to: CGPoint(x: rect.minX + 15.0, y: rect.maxY))
            bezierPath.addLine(to: CGPoint(x: rect.minX + 15.0, y: rect.maxY - 10.0))
        } else {
            bezierPath.move(to: CGPoint(x: rect.maxX - 30.0, y: rect.maxY - 10.0))
            bezierPath.addLine(to: CGPoint(x: rect.maxX - 15.0, y: rect.maxY))
            bezierPath.addLine(to: CGPoint(x: rect.maxX - 15.0, y: rect.maxY - 10.0))
        }

        // fill bubble
        (isIncoming) ? UIColor(red:0.76, green:1.00, blue:0.60, alpha:1.0).setFill() : UIColor(red:0.40, green:1.00, blue:1.00, alpha:1.0).setFill()
        bezierPath.fill()
        bezierPath.close()
    }

}
