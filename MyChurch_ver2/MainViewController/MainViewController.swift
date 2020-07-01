//
//  MainViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/05/03.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit
import FirebaseFirestore

class MainViewController : UIViewController{
    
    @IBOutlet var calanderText: UILabel!
    @IBOutlet var sermonKind: UILabel!
    @IBOutlet weak var sermonImage: UIImageView!
    
    @IBOutlet var todaySermonView: UIView!
    var sermonTap : UIGestureRecognizer!
    
    @IBOutlet var todayNewsView: UIView!
    var newsTap : UIGestureRecognizer!
    
    @IBOutlet var todayColumn: UIView!
    var columnTap : UIGestureRecognizer!
    
    @IBOutlet var moreButton: UIButton!
    @IBOutlet var button: CustomMoreButton!
    
    var docRef : DocumentReference!
    var sermonArr = [Dictionary<String,String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeFirestore()
        setUpNotification()
        sermonImage.layer.cornerRadius = 10
        todayColumn.layer.cornerRadius = 10
        todaySermonView.layer.cornerRadius = 10
        todayNewsView.layer.cornerRadius = 10
        button.layer.cornerRadius = 10
        sermonTap = UITapGestureRecognizer(target: self, action: #selector(self.sermonAction(recognizer:)))
        todaySermonView.addGestureRecognizer(sermonTap)
        newsTap = UITapGestureRecognizer(target: self, action: #selector(self.sermonAction(recognizer:)))
        todayNewsView.addGestureRecognizer(newsTap)
        columnTap = UITapGestureRecognizer(target: self, action: #selector(self.sermonAction(recognizer:)))
        todayColumn.addGestureRecognizer(columnTap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        if identifier == "Sermon" {
            let sc = segue.destination as! SermonViewController
            sc.kind = sermonKind.text
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpDateKind()
        inputDay()
    }
    
    
    func inputDay() {
        let dateFormat = DateFormatter() // 출력할 데이트의 형식을 지정해주는 클래스
        let date = Date(timeIntervalSinceNow: 0) //데이트의 기준점
        dateFormat.locale = Locale(identifier: "ko_KR")
        dateFormat.timeStyle = DateFormatter.Style.none
        dateFormat.dateStyle = DateFormatter.Style.long
        dateFormat.setLocalizedDateFormatFromTemplate("MMMMd")
        calanderText.text = dateFormat.string(from: date)
    }
    
    //MARK:-UIGestrue Action
    
    @objc func sermonAction(recognizer : UIGestureRecognizer) {
        switch recognizer {
        case sermonTap:
            performSegue(withIdentifier: "Sermon", sender: self)
            break
        case newsTap:
            performSegue(withIdentifier: "News", sender: self)
            break
        case columnTap:
            performSegue(withIdentifier: "Column", sender: self)
            break
        default:
            break
        }
    }
    
}

//MARK:- 날짜와 예배의 종류

extension MainViewController {
    
    func setUpDateKind() {
        let date = Date(timeIntervalSinceNow: 0)
        let calender = Calendar(identifier: .gregorian)
        let component = calender.dateComponents([.hour, .minute, .weekday], from: date)
        
        if let day = component.weekday {
            if day == 1 {
                if component.hour! >= 15 && component.hour! <= 17{
                    if component.minute! >= 30 {
                        sermonKind.text = "오후 예배"
                    }
                }else if component.hour! >= 11 && component.hour! <= 13{
                    sermonKind.text = "오전2부 예배"
                    
                }else if component.hour! >= 9 && component.hour! < 11 {
                    sermonKind.text = "오전1부 예배"
                    
                }
            }else if day == 4 {
                if component.hour! >= 20 && component.hour! <= 22 {
                    sermonKind.text = "수요예배"
                }
            }else if day == 6 {
                if component.hour! >= 20 && component.hour! <= 22 {
                    sermonKind.text = "금요예배"
                }
            }
        }
    }
    
    func setUpNotification() {
        if #available(iOS 13.0, *) {
            NotificationCenter.default.addObserver(self, selector: #selector(foregroundNotification), name: UIScene.willEnterForegroundNotification, object: nil)
        }else{
            NotificationCenter.default.addObserver(self, selector: #selector(foregroundNotification), name: UIApplication.willEnterForegroundNotification, object: nil)
        }
    }
    
    @objc func foregroundNotification() {
        setUpDateKind()
        inputDay()
    }
}

//MARK:- 왜 되는지 잘 모르겠음

extension MainViewController {
    func makeFirestore() {
        guard let kind = sermonKind.text else {return}
        let date = Date(timeIntervalSinceNow: 0)
        let calendar = Calendar(identifier: .gregorian)
        let component = calendar.dateComponents([.month, .day], from: date)

        let date_path = "\(String(describing: component.month!))_\(String(describing: component.day!))"

        if kind == "오후 예배"{
            docRef = Firestore.firestore().document("sermon/\(date_path)/kind/evening")
        }else if kind == "오전1부 예배" || kind == "오전2부 예배"{
            docRef = Firestore.firestore().document("sermon/\(date_path)/kind/morning")
        }else if kind == "수요예배"{
            docRef = Firestore.firestore().document("sermon/\(date_path)/kind/wednesday")
        }else if kind == "금요예배"{
            docRef = Firestore.firestore().document("sermon/\(date_path)/kind/friday")
        }else {
            //아무것도 아닌경우 지정해주기
            docRef = Firestore.firestore().document("sermon/\(date_path)/kind/morning")
        }
        getdata()
    }
    
    func getdata() {
        docRef.getDocument {(snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}