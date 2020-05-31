//
//  SermonSequenceView.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/05/07.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

class SermonSequenceView : UIView {
    
    func makeScrollView() {
        self.subviews.forEach{$0.removeFromSuperview()}
        let scrollview = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        scrollview.backgroundColor = UIColor(named: "BackGround")
        self.addSubview(scrollview)
        
        let view = ListView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 80))
        view.center = CGPoint(x: self.frame.width/2, y: 50)
        scrollview.addSubview(view)
        scrollview.contentSize.height = view.frame.height+600
        
        
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = UIColor(named: "BackGround")
        self.makeScrollView()
    }
}
