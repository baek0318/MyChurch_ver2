//
//  FIreStoreData.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/07/18.
//  Copyright © 2020 백승화. All rights reserved.
//
import Foundation
import Firebase

public class FireStoreData {
    
    typealias Completion = () -> Void
    
    private var docRef : DocumentReference!
    private var sermonArr = [Dictionary<String, String>]()
    private var sequenceArr = [Dictionary<String, String>]()
    private var title : String?
    
    private func getDateComponent() -> DateComponents {
        let date = Date(timeIntervalSinceNow: 0)
        let calendar = Calendar(identifier: .gregorian)
        let component = calendar.dateComponents([.month, .day], from: date)
        
        return component
    }
    
    private func getPath() -> String {
        let component = getDateComponent()
        let date_path = "\(String(describing: component.month!))_\(String(describing: component.day!))"
        
        return date_path
    }
    
    func initFirestore(kind : String?) {
        guard let kind = kind else {return}
        let date_path = getPath()
        
        if kind == "오후 예배"{
            docRef = Firestore.firestore().document("sermon/\(date_path)/kind/evening")
        }else if kind == "오전1부 예배" || kind == "오전2부 예배"{
            docRef = Firestore.firestore().document("sermon/\(date_path)/kind/morning")
        }else if kind == "수요예배"{
            docRef = Firestore.firestore().document("sermon/\(date_path)/kind/wednesday")
        }else if kind == "금요예배"{
            docRef = Firestore.firestore().document("sermon/\(date_path)/kind/friday")
        }else {
            docRef = Firestore.firestore().document("sermon/5_31/kind/morning")
        }
    }
    
    func getdata(completion : @escaping Completion) {
        docRef.getDocument { [weak self](snapshot, error) in
            guard let _self = self else {return}
            if let error = error {
                print(error.localizedDescription)
            }else {
                guard let snapshot = snapshot, snapshot.exists else {print("there is no data");return}
                if let data = snapshot.data() {
                    
                    _self.title = data["title"] as? String
                    
                    for i in 1..<data.count {
                        let num = data["\(i)"] as? Dictionary<String,String>
                        _self.sermonArr.append(num ?? ["" : ""])
                    }
                    
                    let sequneceData = data["sequence"] as? Dictionary<String, Dictionary<String,String>>
                    guard let sequence = sequneceData else {return}
                    for i in 1...sequence.count {
                        guard let num = sequence["\(i)"] else {return}
                        _self.sequenceArr.append(num)
                    }
                }
            }
        }
        completion()
    }
    
    
}
