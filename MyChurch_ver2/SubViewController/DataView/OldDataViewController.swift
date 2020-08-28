//
//  OldDataViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/07/11.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit
import Firebase

class OldDataViewController : UITableViewController {
    
    @IBOutlet var sermonTableView: UITableView!
    
    private var documentIDArr = [String]()
    
    private var data = [Dictionary<String, String>]()
    
    private var loadingView : LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        sermonTableView.delegate = self
        sermonTableView.dataSource = self
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            let dvc = segue.destination as! DataViewController
            let data = sender as! Dictionary<String, String>
            dvc.kind = data["kind"]
            dvc.date = data["date"]
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data.count != 0  {
            data.sort { (dic1, dic2) in
                let date1 = dic1["date"]!.split(separator: " ")
                let date2 = dic2["date"]!.split(separator: " ")
                let month1 = MonthStringToInt.init(rawValue: String(date1[0]))?.StringToInt()
                let month2 = MonthStringToInt.init(rawValue: String(date2[0]))?.StringToInt()
                let day1 = DayStringToInt.init(rawValue: String(date1[1]))?.StringToInt()
                let day2 = DayStringToInt.init(rawValue: String(date2[1]))?.StringToInt()
                if month1! == month2! {
                    if day1! > day2! {
                        return true
                    }else {
                        return false
                    }
                }
                else if month1! > month2! {
                    return true
                }
                else {
                    return false
                }
            }
        }
        
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIdx = data[indexPath.row]
        let cell = sermonTableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? DataTableViewCell
        cell?.title.font = UIFont.preferredFont(forTextStyle: .headline)
        cell?.title.text = dataIdx["kind"]
        
        cell?.subTitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
        cell?.subTitle.text = dataIdx["date"]
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Detail", sender: data[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

//MARK:- FireStore

extension OldDataViewController {
    func getData() {
        let db = Firestore.firestore()
        var num = 0
        
        db.collection("sermon").getDocuments {[weak self] (querySnapshot, error) in
            guard let _self = self else {return}
            
            if let _error = error {
                print(_error.localizedDescription)
            }
            else {
                guard let snapshot = querySnapshot else {return}
                for document in snapshot.documents {
                    _self.documentIDArr.append(document.documentID)
                }
                
                for i in _self.documentIDArr {
                    db.collection("sermon/\(i)/kind").whereField("exist", isEqualTo: true).getDocuments { (existSnapShot, error) in
                        num+=1
                        if let _error = error {
                            print(_error.localizedDescription)
                        }
                        else {
                            guard let snapshot = existSnapShot else {return}
                            for doc in snapshot.documents {
                                let dateArr = i.split(separator: "_")
                                let date = dateArr[0]+"월"+" "+dateArr[1]+"일"
                                let kind = Kind.init(rawValue: doc.documentID)?.korean() ?? ""
                                _self.data.append(["date" : date, "kind" : kind])
                            }
                        }
                        if num == _self.documentIDArr.count {
                            _self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
}
