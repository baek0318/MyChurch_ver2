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
    var saveData : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTalbeView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else {return}
        if id == "ListSegue"{
            let lvc = segue.destination as! ListViewController
            lvc.saveTitle = saveData
        }else if id == "MapSegue"{
            let locationVC = segue.destination as! LocationViewController
            locationVC.saveTitle = saveData
        }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            saveData = data[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: "ListSegue", sender: self); break
        case 1:
            saveData = data[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: "ListSegue", sender: self); break
        case 2:
            saveData = data[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: "ListSegue", sender: self); break
        case 3:
            saveData = data[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: "MapSegue", sender: self); break
        default:
            break
        }
    }
    
}
