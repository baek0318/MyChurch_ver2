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

    var animationView : AnimationView?
    
    convenience init(name : String) {
        self.init()
        if name == "loading" {
            self.backgroundColor = UIColor(red: 0.12, green: 0.58, blue: 0.95, alpha: 1.00)
        }
        animationView = .init(name: name)
        animationView?.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(animationView!)
        let constraints = animationView?.fullConstraintsForAnchorsTo(view: self)
        NSLayoutConstraint.activate(constraints!)
        
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 1.5
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
