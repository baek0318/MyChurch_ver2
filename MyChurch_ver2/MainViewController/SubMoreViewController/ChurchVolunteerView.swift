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
    
    var churchVolunteeredData = [Dictionary<String, String>]()
    
    var fontSize : CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setFontSize()
        setSuperTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///setFontSize
    func setFontSize() {
        let userDefault = UserDefaults.standard
        if userDefault.float(forKey: "fontSetting") != 0 {
            fontSize = CGFloat(userDefault.float(forKey: "fontSetting"))
        }else {
            fontSize = 0
        }
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
    
    func getChurchVolunteerTable() -> UITableView {
        return self.superTableView
    }
}

extension ChurchVolunteerView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return churchVolunteeredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let data = churchVolunteeredData[indexPath.row]
            
        let cell = self.superTableView.dequeueReusableCell(withIdentifier: "OfferCell", for: indexPath) as! OfferingTableViewCell
        
        if fontSize != 0 {
            cell.offeredName.font = UIFont.systemFont(ofSize: fontSize!)
        }
        
        cell.offeringKind.text = data["title"]?.replacingOccurrences(of: "\\n", with: "\n")
        cell.offeredName.text = data["content"]?.replacingOccurrences(of: "\\n", with: "\n")
            
        return cell

    }
    
    
}
