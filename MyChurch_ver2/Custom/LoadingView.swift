//
//  LoadingView.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/16.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit
import Lottie

class LoadingView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var animationView : AnimationView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.12, green: 0.58, blue: 0.95, alpha: 1.00)
        animationView = .init(name: "loading")
        animationView?.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(animationView!)
        let constraints = animationView?.fullConstraintsForAnchorsTo(view: self)
        NSLayoutConstraint.activate(constraints!)
        
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 1.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stopLoading() {
        animationView?.stop()
    }
    
    func startLoading() {
        animationView?.play()
    }
}
