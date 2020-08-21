//
//  CustomGesture.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/20.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class CustomGesture: UIGestureRecognizer {
    
    private var changingP : CGPoint?
    
    private var originPos : CGPoint = CGPoint(x: 0, y: 0)
    
    var initPos : CGPoint {
        get {
            return originPos
        }
        set {
            originPos = newValue
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        self.state = .began
        print("began")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        let touch = touches.first!
        changingP = touch.previousLocation(in: touch.view)
    }
    
    override func location(in view: UIView?) -> CGPoint {
        let point = changingP ?? CGPoint(x: 0, y: 0)
        let posY = point.y
        view?.frame.origin.y = posY
        
        return view!.frame.origin
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        self.state = .ended
        print("ended")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
    }
}
