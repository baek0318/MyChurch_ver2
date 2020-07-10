//
//  CustomCloseButton.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/05/03.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

@IBDesignable
class CustomCloseButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(ovalIn: rect)
        UIColor.lightGray.setFill()
        path.fill(with: .color, alpha: 0.5)
        
        let closePath = UIBezierPath()
        closePath.lineWidth = 2.0
        closePath.move(to: CGPoint(x: 12.0, y: 24.0))
        closePath.addLine(to: CGPoint(x: 24.0, y: 12.0))
        UIColor.white.setStroke()
        closePath.lineCapStyle = .round
        closePath.stroke()

        let closePath2 = UIBezierPath()
        closePath2.lineWidth = 2.0
        closePath2.move(to: CGPoint(x: 12.0, y: 12.0))
        closePath2.addLine(to: CGPoint(x: 24.0, y: 24.0))
        UIColor.white.setStroke()
        closePath2.lineCapStyle = .round
        closePath2.stroke()
    }
}
