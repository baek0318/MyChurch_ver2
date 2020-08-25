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
    var fontSize : CGFloat?
    @IBOutlet weak var noData: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFontSize()
        createTable()
        getData()
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
        
        if fontSize != 0 {
            cell.newsKind.font = UIFont.systemFont(ofSize: fontSize!, weight: UIFont.Weight(rawValue: 0.3))
            cell.newsTitle.font = UIFont.boldSystemFont(ofSize: fontSize!+3)
            cell.newsText.font = UIFont.systemFont(ofSize: fontSize!)
        }
        
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
                guard let docSnapshot = docSnapshot, docSnapshot.exists else {_self.noData.isHidden = false ;return}
                if let data = docSnapshot.data() as? Dictionary<String, Dictionary<String, String>> {
                    for i in 1...data.count {
                        if let newData = data["\(i)"] {
                            _self.newArr.append(newData)
                        }
                    }
                }
            }
            _self.tableView.reloadData()
        })
    }
}
