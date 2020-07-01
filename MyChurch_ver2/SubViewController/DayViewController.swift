//
//  DayViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/06/27.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

class DayViewController : UIViewController {
    
    @IBOutlet weak var calendarTable: UITableView!
    
    @IBOutlet weak var noData: UIView!
    
    var data : [String] = []
    
    var dateTitle : String?
    
    override func viewDidLoad() {
        calendarTable.delegate = self
        calendarTable.dataSource = self
        if data.isEmpty {
            noData.isHidden = false
        }else {
            noData.isHidden = true
        }
        
        self.navigationItem.title = dateTitle ?? "0월 0일"
        super.viewDidLoad()
    }
    
}

//MARK:- Delegate & DataSource

extension DayViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.calendarTable.dequeueReusableCell(withIdentifier: "DataCell")
        print(indexPath)
        cell?.textLabel?.text = data[indexPath.row]
        
        return cell!
    }
    
    
}
