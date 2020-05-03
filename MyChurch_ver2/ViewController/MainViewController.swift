//
//  MainViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/05/03.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

class MainViewController : UIViewController {
    
    @IBOutlet var todaySermonView: UIView!
    var sermonTap : UIGestureRecognizer!
    
    @IBOutlet var todayNewsView: UIView!
    var newsTap : UIGestureRecognizer!
    
    @IBOutlet var todayColumn: UIView!
    var columnTap : UIGestureRecognizer!
    
    @IBOutlet var moreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todayColumn.layer.cornerRadius = 10
        todaySermonView.layer.cornerRadius = 10
        todayNewsView.layer.cornerRadius = 10
        sermonTap = UITapGestureRecognizer(target: self, action: #selector(self.sermonAction(recognizer:)))
        todaySermonView.addGestureRecognizer(sermonTap)
        newsTap = UITapGestureRecognizer(target: self, action: #selector(self.sermonAction(recognizer:)))
        todayNewsView.addGestureRecognizer(newsTap)
        columnTap = UITapGestureRecognizer(target: self, action: #selector(self.sermonAction(recognizer:)))
        todayColumn.addGestureRecognizer(columnTap)
    }
    
    @objc func sermonAction(recognizer : UIGestureRecognizer) {
        switch recognizer {
        case sermonTap:
            performSegue(withIdentifier: "Sermon", sender: self)
            break
        case newsTap:
            performSegue(withIdentifier: "News", sender: self)
            break
        case columnTap:
            performSegue(withIdentifier: "Column", sender: self)
            break
        default:
            break
        }
    }
    
}
