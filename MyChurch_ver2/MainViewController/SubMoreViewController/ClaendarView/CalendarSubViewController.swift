//
//  CalendarSubViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/20.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit
import Firebase

class CalendarSubViewController : UIViewController {
    
    private var subView : CalendarTableView!
    
    private var startP : CGFloat = 0
    private var endP : CGFloat = 0
    var today : Int?
    private var originPos : CGFloat?
    private var tapGesture : UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSuperView()
        getScheduleData()
    }
    
    func setSuperView() {
        let tapView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        tapView.backgroundColor = UIColor(white: 0, alpha: 0)
        view.addSubview(tapView)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapClose(recognizer:)))
        tapView.addGestureRecognizer(tapGesture!)
        
        let frame = CGRect(x: 0, y: 70, width: self.view.frame.width, height: self.view.frame.height-70)
        self.subView = CalendarTableView(frame: frame, day: today ?? 0)
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.layer.masksToBounds = true
        subView.getTableView().isUserInteractionEnabled = false
        view.addSubview(subView)
        
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
    
    @objc func tapClose(recognizer : UIGestureRecognizer) {
        
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
    
    func getSubView() -> CalendarTableView {
        return self.subView
    }
    
    func setMonthNDay() -> DateComponents {
        let calednar = Calendar(identifier: .gregorian)
        let date = Date()
        let components = calednar.dateComponents([.month, .day,.weekday], from: date)
        
        return components
    }
}

extension CalendarSubViewController {
    func setCalendarTableConstraint(tableHeight : CGFloat) {
        var tableHeight = tableHeight
        
        if self.view.frame.height-80 < tableHeight {
            tableHeight = self.view.frame.height-80
            self.subView.getTableView().isUserInteractionEnabled = true
        }
        self.originPos = self.view.frame.height - tableHeight
        
        self.subView.heightAnchor.constraint(equalToConstant: tableHeight).isActive = true
        self.subView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.view.trailingAnchor.constraint(equalTo: self.subView.trailingAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: self.subView.bottomAnchor).isActive = true
    }
    
    func getScheduleData() {
        let month = setMonthNDay().month!
        let db = Firestore.firestore()
        db.document("schedule/\(month)/schedules/\(today!)").getDocument { [weak self] (snapshot, error) in
            guard let _self = self else {return}
            if let _error = error {
                fatalError(_error.localizedDescription)
            }else {
                guard let snapshot = snapshot, snapshot.exists else {_self.setCalendarTableConstraint(tableHeight: 180);return}
                if let data = snapshot.data() as? Dictionary<String, Dictionary<String, String>> {
                    for i in 1...data.count {
                        if let num = data["\(i)"] {
                            _self.getSubView().scheduledData.append(num)
                        }
                    }
                }
            }
            _self.getSubView().getTableView().reloadData()
            
            let tableHeight = _self.subView.getTableView().contentSize.height+150
            _self.setCalendarTableConstraint(tableHeight: tableHeight)
        }
    }
}
