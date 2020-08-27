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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sermonTableView.delegate = self
        sermonTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sermonTableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        
        cell.textLabel?.text = "title"
        cell.detailTextLabel?.text = "kind"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
}

//MARK:- FireStore

extension OldDataViewController {
    func getData() {
        let db = Firestore.firestore()
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
        
        
        db.document("news/\(date_path)").getDocument(completion: {[weak self] (docSnapshot, error) in
            guard let _self = self else {return}
            if let error = error {
                print(error.localizedDescription)
            }else {
                guard let docSnapshot = docSnapshot, docSnapshot.exists else {return}
                if let data = docSnapshot.data() as? Dictionary<String, Dictionary<String, String>> {
                    for i in 1...data.count {
                        if let newData = data["\(i)"] {
                            
                        }
                    }
                }
            }
            _self.sermonTableView.reloadData()
        })
    }
}
