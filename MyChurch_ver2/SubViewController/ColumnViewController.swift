//
//  ColumnViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/05/03.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ColumnViewController : UIViewController {
    
    @IBOutlet var columnTitle: UILabel!
    @IBOutlet var textView: UITextView!
    
    var docRef : DocumentReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        textView.isEditable = false
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
//MARK:- FireStore Data read

extension ColumnViewController {
    func getData() {
        let date = Date(timeIntervalSinceNow: 0)
        let calendar = Calendar(identifier: .gregorian)
        let component = calendar.dateComponents([.month, .day], from: date)
        
        let date_path = "\(String(describing: component.month!))_\(String(describing: component.day!))"
        docRef = Firestore.firestore().document("columns/\(date_path)")
        
        docRef?.getDocument(completion: {[weak self] (docSnapshot, error) in
            guard let _self = self else {return}
            if let error = error {
                print(error.localizedDescription)
            }else {
                if let data = docSnapshot?.data() as? Dictionary<String,String> {
                    _self.columnTitle.text = data["title"]?.replacingOccurrences(of: "\\n", with: "\n")
                    _self.textView.text = data["content"]?.replacingOccurrences(of: "\\n", with: "\n")
                }
            }
        })
    }
}
