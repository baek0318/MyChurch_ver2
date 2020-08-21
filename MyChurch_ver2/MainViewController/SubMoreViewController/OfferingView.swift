//
//  OfferingView.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/16.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit
import FirebaseFirestore

class OfferingView: UIView {
    
    @UserAutoLayout
    private var superTableView = UITableView()
    
    var docRef : DocumentReference!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- setSuperTableView
    
    private func setSuperView() {
        let nib = UINib(nibName: "OfferingTableViewCell", bundle: nil)
        self.superTableView.register(nib, forCellReuseIdentifier: "OfferCell")
        self.superTableView.delegate = self
        self.superTableView.dataSource = self
        self.superTableView.separatorStyle = .none
        self.superTableView.rowHeight = UITableView.automaticDimension
        self.superTableView.estimatedRowHeight = 600
        addSubview(superTableView)
        let constraints = superTableView.fullConstraintsForAnchorsTo(view: self)
        NSLayoutConstraint.activate(constraints)
        
    }
}

extension OfferingView : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.superTableView.dequeueReusableCell(withIdentifier: "OfferCell", for: indexPath) as! OfferingTableViewCell
        
        cell.offeringKind.text = "십일조"
        cell.offeredName.text = "강성원 공준호 권수경 권영현 권찬오 권창범 김갑연 김경은 김구현 김다영 김령희 김미나 김상균 김상은 김서현b 김성은a 김소희a 김수연 김순철 김승수 김신재 김영미 김영희a 김예빈a 김예빈b 김옥선 김유현 김율한 김은수b 김의진b 김정실 김주영 김지영d 김진희 김하영 김한선 류승곤 류승주 문동혁 문정혁 박  건 박나현 박승찬 박예담b 박요한 박윤주 박지성 박지용 박지은 박진주a 박채린 방창극 방창현 배은진 배지현 백성엽 변유성 송미섭 송지윤 신가윤 신선영 심숙미 양은서 양춘규 오문숙 오은주 윤영환 이미숙a 이상렬 이서현 이수인 이시우 이영주 이영훈 이영훈 이윤서 이재용 이충언 장우진 장재용 장준영 장준혁 장해창 전흥표 정가은 정소영 정이레 정인숙 정  진 정진하 조광현 조동현a 조영현 조우현 조은우 조은찬 조인영 조형철 최명길 최아인 최정미 최창록 최효희 홍리아 홍수아 황애진 황예지 무명2"
        
        return cell
    }
}

//MARK:- FireStore Data read
/*
extension OfferingView {
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
