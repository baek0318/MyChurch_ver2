//
//  File.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/21.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

class AdContentViewController : UIViewController {
    
    var imageView : UIImageView!
    
    var idx : Int!
    
    var imgStr : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageView()
    }
    
    func setImageView() {
        self.imageView = UIImageView()
        self.imageView.image = UIImage(named: imgStr)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.imageView)
        let constraints = self.imageView.fullConstraintsForAnchorsTo(view: self.view)
        NSLayoutConstraint.activate(constraints)
    }

}
