//
//  CalendarSubViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/20.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

class CalendarSubViewController : UIViewController {
    
    private var subView : CalendarTableView!
    
    private var startP : CGFloat = 0
    private var endP : CGFloat = 0
    var today : Int?
    private var originPos : CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSuperView()
    }
    
    func setSuperView() {
        let frame = CGRect(x: 0, y: 70, width: self.view.frame.width, height: self.view.frame.height-70)
        self.subView = CalendarTableView(frame: frame,day: today ?? 0)
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.layer.masksToBounds = true
        subView.getTableView().isUserInteractionEnabled = false
        view.addSubview(subView)
        
        var tableHeight = subView.getTableView().contentSize.height+200
        
        if self.view.frame.height-80 < tableHeight {
            tableHeight = self.view.frame.height-80
            subView.getTableView().isUserInteractionEnabled = true
        }
        originPos = self.view.frame.height - tableHeight
        
        subView.heightAnchor.constraint(equalToConstant: tableHeight).isActive = true
        subView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.view.trailingAnchor.constraint(equalTo: subView.trailingAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: subView.bottomAnchor).isActive = true
        
        subView.transform = CGAffineTransform(translationX: 0, y: 500)
        let downGesture = UIPanGestureRecognizer(target: self, action: #selector(self.updownGesture(recognizer:)))
        subView.addGestureRecognizer(downGesture)
        
    }
    
    @objc func close(sender : UIButton ) {
        UIView.animate(withDuration: 0.25 , animations: {
            self.subView.transform = CGAffineTransform(translationX: 0, y: 600)
            self.view.alpha = 0
        }) { (_) in
            self.dismiss(animated: false )
        }
    }
    
    @objc func updownGesture(recognizer : UIPanGestureRecognizer) {
        let pos = recognizer.translation(in: subView)
        let oriPos = subView.frame.origin

        if oriPos.y + pos.y <= originPos! {
            recognizer.state = .cancelled
        }
        else {
            subView.frame.origin.y = oriPos.y + pos.y
            recognizer.setTranslation(CGPoint.zero, in: subView)
        }
        
        if recognizer.state == UIGestureRecognizer.State.ended {
            UIView.animate(withDuration: 0.25 , animations: {
                self.subView.transform = CGAffineTransform(translationX: 0, y: 600)
                self.view.alpha = 0
            }) { (_) in
                self.dismiss(animated: false )
            }
        }
    }
    
    func getSubView() -> UIView {
        return self.subView
    }
    
}

extension UIPanGestureRecognizer {
    
}
