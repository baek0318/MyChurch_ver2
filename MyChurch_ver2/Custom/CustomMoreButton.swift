//
//  CustomMoreButton.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/05/03.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

@IBDesignable
class CustomMoreButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(rect: rect)
        if let color = UIColor(named: "moreBotton") {
            color.setFill()
            path.fill()
        }else {
            UIColor.lightGray.setFill()
            path.fill()
        }
    }

}
