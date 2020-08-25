//
//  MoreViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/14.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit
import Firebase

class MoreViewController : UIViewController {
    
    @UserAutoLayout
    var superStackView = UIStackView()
    
    @UserAutoLayout
    var topBarStackView = UIStackView()
    
    @UserAutoLayout
    var mainView = UIScrollView()
    
    var offeringView : OfferingView!
    
    var calendarView : CalendarView!
    
    var churchVolunteer : ChurchVolunteerView!
    
    var tabBar : TabBarViewControl!
    
    var height : CGFloat?
    
    var today : Int?
    
    var docRef : DocumentReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSuperStackView()
        deviceCheck()
        setCalendarView()
        setOfferingView()
        setChurchVolunteerView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Vertical" {
            let desti = segue.destination as? CalendarSubViewController
            desti?.today = self.today
        }
    }
    
    func deviceCheck() {
        if UIDevice().userInterfaceIdiom == .phone {
          switch UIScreen.main.nativeBounds.height {
            case 1136:
            //"iPhone se"
                self.height = self.mainView.frame.height-70
            break
            case 1334:
            //"iPhone 6/6S/7/8"
                self.height = self.mainView.frame.height-70
            break
            case 2208:
            //"iPhone 6+/6S+/7+/8+"
                self.height = self.mainView.frame.height-70
            break
            case 2436:
            //"iPhone X"
                self.height = self.mainView.frame.height-130
            break
            case 2688:
            //"iPhone 11pro Max"
                self.height = self.mainView.frame.height-130
            break
            case 1792:
            //"iPhone 11/Xr"
                self.height = self.mainView.frame.height-130
            break
            default:
            print("unknown")
          }
        }
        else {
            self.height = self.mainView.frame.height-70
        }
    }
    
    //MARK:- SuperStackView
    
    func setSuperStackView() {
        superStackView.axis = .vertical
        superStackView.alignment = .fill
        superStackView.distribution = .fill
        superStackView.spacing = 20
        
        self.view.addSubview(superStackView)
        let constraints = superStackView.eachSafeAreaConstraintsForAnchorsTo(view: self.view, top: 10, leading: 5, bottom: 0, trailing: 5)
        NSLayoutConstraint.activate(constraints)
        
        let topView = setTopView()
        
        let mainView = setMainView()
        
        superStackView.addArrangedSubview(topView)
        superStackView.addArrangedSubview(mainView)
        superStackView.layoutIfNeeded()
        
    }
    
    
    //MARK:- topBarView
    
    func setTopView() -> UIView {
        self.topBarStackView.axis = .horizontal
        self.topBarStackView.alignment = .fill
        self.topBarStackView.distribution = .fill
        self.topBarStackView.spacing = 0
        
        self.tabBar = TabBarViewControl(buttonTitle: ["일정", "헌금", "교회 섬김이"])
        self.tabBar.delegate = self
        
        let spacingView = UIView()
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 2
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapSetting(recognizer:)))
        stackView.addGestureRecognizer(tapGesture)
        
        let settingImage = UIImageView()
        settingImage.image = UIImage(named: "setting")
        settingImage.translatesAutoresizingMaskIntoConstraints = false
        settingImage.heightAnchor.constraint(equalTo: settingImage.widthAnchor).isActive = true
        settingImage.heightAnchor.constraint(equalToConstant: 19).isActive = true
        settingImage.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        settingImage.setContentCompressionResistancePriority(UILayoutPriority(749), for: .horizontal)
        
        let settingLabel = UILabel()
        settingLabel.text = "설정"
        
        stackView.addArrangedSubview(settingImage)
        stackView.addArrangedSubview(settingLabel)
        
        topBarStackView.addArrangedSubview(self.tabBar)
        topBarStackView.addArrangedSubview(spacingView)
        topBarStackView.addArrangedSubview(stackView)
        
        return self.topBarStackView
    }
    
    @objc func tapSetting(recognizer : UITapGestureRecognizer) {
        performSegue(withIdentifier: "Setting", sender: nil)
    }
    
    //MARK:- MainView
    
    func setMainView() -> UIView {
        self.mainView.contentSize.width = self.view.frame.width*3
        self.mainView.showsHorizontalScrollIndicator = false
        self.mainView.isPagingEnabled = true
        self.mainView.delegate = self
        
        return self.mainView
    }
    
    func setCalendarView() {
        let width = (self.mainView.contentSize.width - 30)/3
        self.calendarView = CalendarView(frame: CGRect(x: 0, y: 0, width: width, height: height!))
        self.calendarView.delegate = self
        
        self.mainView.addSubview(self.calendarView)
    }
    
    
    func setOfferingView() {
        let width = (self.mainView.contentSize.width - 30)/3
        self.offeringView = OfferingView(frame: CGRect(x: width, y: 0, width: width, height: height!))
        
        self.mainView.addSubview(self.offeringView)
        
        getOfferingData()
    }
    
    func setChurchVolunteerView() {
        let width = (self.mainView.contentSize.width - 30)/3
        self.churchVolunteer = ChurchVolunteerView(frame: CGRect(x: width*2, y: 0, width: width, height: height!))
        
        self.mainView.addSubview(self.churchVolunteer)
        
        getChurchVolunteerData()
    }
    
    func setMonthNDay() -> DateComponents {
        let calednar = Calendar(identifier: .gregorian)
        let date = Date()
        let components = calednar.dateComponents([.month, .day,.weekday], from: date)
        
        return components
    }
}

//MARK:- ScrollViewDelegate

extension MoreViewController : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let xPos = scrollView.contentOffset.x
        let width = self.view.frame.width - 10
        let index = (xPos/width)
        self.tabBar.selectorAction(index: Int(index))
    }
}

//MARK:- TabBarDelegate

extension MoreViewController : TabBarViewControlDelegate {
    func pageChange(index: Int) {
        self.mainView.contentOffset.x = (self.view.frame.width-10)*CGFloat(index)
    }
}

extension MoreViewController : CalendarViewDelegate {
    func actionSegue() {
        performSegue(withIdentifier: "Vertical", sender: nil)
    }
    
    func postDay(data: Int) {
        self.today = data
    }
}

//MARK:- getOfferingData

extension MoreViewController {
    func getOfferingData() {
        let db = Firestore.firestore()
        let month = setMonthNDay().month!
        let day = setMonthNDay().day!
        let weekday = setMonthNDay().weekday!
        
        var date_path = ""
        
        if weekday == 1 || weekday == 4 {
            date_path = "\(month)_\(day)"
        }
        else {
            date_path = "\(month)_\((day - (weekday-1)))"
        }
        
        db.document("offering/\(date_path)").getDocument { [weak self] (snapshot, error) in
            guard let _self = self else {return}
            if let _error = error {
                fatalError(_error.localizedDescription)
            }else {
                guard let snapshot = snapshot, snapshot.exists else {print("there is no data");return}
                if let data = snapshot.data() as? Dictionary<String, Dictionary<String, String>> {
                    for i in 1..<data.count {
                        if let num = data["\(i)"] {
                            _self.offeringView.offeredData.append(num)
                        }
                    }
                }
            }
            _self.offeringView.getOfferingTableView().reloadData()
        }
    }
}

//MARK:- getChurchVolunteerData

extension MoreViewController {
    func getChurchVolunteerData() {
        let db = Firestore.firestore()
        let month = setMonthNDay().month!
        let day = setMonthNDay().day!
        let weekday = setMonthNDay().weekday!
        
        var date_path = ""
        
        if weekday == 1 || weekday == 4 {
            date_path = "\(month)_\(day)"
        }
        else {
            date_path = "\(month)_\((day - (weekday-1)))"
        }
        
        db.document("volunteer/\(date_path)").getDocument { [weak self] (snapshot, error) in
            guard let _self = self else {return}
            if let _error = error {
                fatalError(_error.localizedDescription)
            }else {
                guard let snapshot = snapshot, snapshot.exists else {print("there is no data");return}
                if let data = snapshot.data() as? Dictionary<String, Dictionary<String, String>> {
                    for i in 1...data.count {
                        if let num = data["\(i)"] {
                            _self.churchVolunteer.churchVolunteeredData.append(num)
                        }
                    }
                }
            }
            _self.churchVolunteer.getChurchVolunteerTable().reloadData()
        }
    }
}
