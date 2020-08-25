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
    @IBOutlet weak var noData: UIView!
    var fontSize : CGFloat?
    var docRef : DocumentReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFontSize()
        getData()
        textView.isEditable = false
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
//MARK:- FireStore Data read

extension ColumnViewController {
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
        
        docRef = Firestore.firestore().document("columns/\(date_path)")
        
        docRef?.getDocument(completion: {[weak self] (docSnapshot, error) in
            guard let _self = self else {return}
            if let error = error {
                print(error.localizedDescription)
            }else {
                if let data = docSnapshot?.data() as? Dictionary<String,String> {
                    if _self.fontSize != 0 {
                        _self.textView.font = UIFont.systemFont(ofSize: _self.fontSize!, weight: UIFont.Weight(0.2))
                    }
                    _self.columnTitle.text = data["title"]?.replacingOccurrences(of: "\\n", with: "\n")
                    _self.textView.text = data["content"]?.replacingOccurrences(of: "\\n", with: "\n")
                    if _self.columnTitle.text == "칼럼" {
                        _self.noData.isHidden = false
                    }else{
                        _self.noData.isHidden = true
                    }
                }else{
                    _self.noData.isHidden = false
                }
            }
            
        })
    }
}
