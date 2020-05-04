//
//  MoreViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/05/03.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

class MoreViewController : UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var data : [String] = ["차량운행","목장안내","선교현황","교회위치"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTalbeView()
    }
}

//MARK:- TableView Delegate & DataSource

extension MoreViewController : UITableViewDelegate, UITableViewDataSource {
    
    func configTalbeView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isScrollEnabled = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = data[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = row
        
        return cell
    }
    
    
    
}
