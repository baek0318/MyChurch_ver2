//
//  ChurchVolunteerView.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/16.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ChurchVolunteerView: UIView {

    @UserAutoLayout
    private var superTableView = UITableView()
    
    var docRef : DocumentReference!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSuperTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSuperTableView() {
        let nib = UINib(nibName: "OfferingTableViewCell", bundle: nil)
        superTableView.register(nib, forCellReuseIdentifier: "OfferCell")
        superTableView.delegate = self
        superTableView.dataSource = self
        superTableView.rowHeight = UITableView.automaticDimension
        superTableView.estimatedRowHeight = 600
        superTableView.separatorStyle = .none
        
        addSubview(superTableView)
        let constraints = superTableView.fullConstraintsForAnchorsTo(view: self)
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension ChurchVolunteerView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = superTableView.dequeueReusableCell(withIdentifier: "OfferCell", for: indexPath) as! OfferingTableViewCell
        
        cell.offeringKind.text = "다음주 담당"
        cell.offeredName.text = "대예배기도 : 이두우 장로\n봉헌송 : 마하나임\n오후예배기도 : 인태경 집사\n오후예배특송 :  -\n수요예배기도 : 김은주a 집사\n목요새벽설교 : 김성곤목장\n화요어린이설교 : 이현석 집사\n8월 주차안내 : 임흥식초원"
        
        return cell
    }
    
    
}

//MARK:- FireStore Data read
/*
extension ChurchVolunteerView {
    func getData() {
        let date = Date(timeIntervalSinceNow: 0)
        let calendar = Calendar(identifier: .gregorian)
        let component = calendar.dateComponents([.month, .day, .weekday], from: date)
        
        var date_path = ""
        
        if component.weekday! == 1 {
            date_path = "\(String(describing: component.month!))_\(String(describing: component.day!))"
        }
        else {
            date_path = "\(String(describing: component.month!))_\(String(describing: (component.day! - (component.weekday!-1))))"
        }
        
        docRef = Firestore.firestore().document("news/\(date_path)")
        
        docRef?.getDocument(completion: {[weak self] (docSnapshot, error) in
            guard let _self = self else {return}
            if let error = error {
                print(error.localizedDescription)
            }else {
                
            }
        })
    }
}
*/
