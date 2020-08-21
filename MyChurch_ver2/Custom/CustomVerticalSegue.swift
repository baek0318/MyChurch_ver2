//
//  CustomVerticalSegue.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/20.
//  Copyright © 2020 백승화. All rights reserved.
//
import UIKit

class CustomVerticalSegue: UIStoryboardSegue {
    
    var start : UIViewController!
    var desti : CalendarSubViewController!
    
    override init(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination)
        self.start = source
        self.desti = destination as? CalendarSubViewController
    }
    
    override func perform() {
        desti.view.backgroundColor = UIColor(named: "segueBack")
        desti.view.alpha = 0
        desti.modalPresentationStyle = .overFullScreen
        start.view.superview?.insertSubview(desti.view, aboveSubview: start.view)
        let subView = desti.getSubView()

        UIView.animate(withDuration:0.25, animations:  {
            self.desti.view.alpha = 1
            subView.transform = CGAffineTransform.identity
            self.start.tabBarController?.tabBar.isHidden = true
        }) { (_) in
            self.start.present(self.desti, animated: false) {
                self.start.tabBarController?.tabBar.isHidden = false
            }
        }
    }
}
