//
//  LocationViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/06/04.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController : UIViewController {
    
    @IBOutlet var titleName: UILabel!
    var saveTitle : String?
    
    override func viewDidLoad() {
        self.titleName.text = saveTitle
        super.viewDidLoad()
    }
    
    @IBAction func moveToBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
