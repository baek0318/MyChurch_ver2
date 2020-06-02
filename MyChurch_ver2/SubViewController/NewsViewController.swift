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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        createTable()
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
        let component = calendar.dateComponents([.month, .day], from: date)
        
        let date_path = "\(String(describing: component.month!))_\(String(describing: component.day!))"
        docRef = Firestore.firestore().document("news/5_31")
        
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
        })
    }
}
