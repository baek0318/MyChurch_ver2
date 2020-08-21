//
//  NewsViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/05/03.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit
import FirebaseFirestore

class NewsViewController : UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var docRef : DocumentReference?
    var newArr = [Dictionary<String, String>]()
    @IBOutlet weak var noData: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTable()
        getData()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

//MARK:-UITableView Delegate, Data

extension NewsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func createTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 600
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = newArr[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        
        cell.newsKind.text = index["kind"]?.replacingOccurrences(of: "\\n", with: "\n")
        cell.newsTitle.text = index["title"]?.replacingOccurrences(of: "\\n", with: "\n")
        cell.newsText.text = index["content"]?.replacingOccurrences(of: "\\n", with: "\n")
        
        return cell
    }
}

//MARK:- FireStore Data read

extension NewsViewController {
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
                let data = docSnapshot?.data() as? Dictionary<String, Dictionary<String, String>> ?? ["":["":""]]
                for i in 1...data.count {
                    _self.newArr.append(data["\(i)"] ?? ["":""])
                }
            }
            _self.tableView.reloadData()
            if _self.newArr.count != 0 {
                _self.noData.isHidden = true
            }else {
                _self.noData.isHidden = false
            }
        })
    }
}
