//
//  CalendarView.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/14.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

@objc protocol CalendarViewDelegate : AnyObject {
    @objc optional func actionSegue()
    
    @objc optional func postDay(data : Int)
}

class CalendarView : UIView {
    
    @UserAutoLayout
    private var superScrollView = UIScrollView()
    
    @UserAutoLayout
    private var topView = UIView()
    
    @UserAutoLayout
    private var superStackView = UIStackView()
    
    @UserAutoLayout
    private var calenderStackView = UIStackView()
    
    @UserAutoLayout
    private var monthLabel = UILabel()
    
    private var calendarTableView : CalendarTableView?
    
    private var calendar = Calendar(identifier: .gregorian)
    
    private let date = Date()
    
    private var day : String?
    
    private var month : Int?
    
    private var today : DateComponents?
    
    private var impactFeedbackGenerator : UIImpactFeedbackGenerator?
    
    weak var delegate : CalendarViewDelegate?
    
    //달력에서 전에 pick한 날짜를 저장하는 공간
    private var beforeDay = UILabel()
    
    //오늘 날짜 UILabel을 저장하는 공간
    private var todayLabel : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.today = calendar.dateComponents([.day], from: date)
        self.setSuperView()
        self.setTitleNDate()
        self.makeNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func makeNotification() {
        if #available(iOS 13.0, *){
            NotificationCenter.default.addObserver(self, selector: #selector(foregroundNotification), name: UIScene.willEnterForegroundNotification, object: nil)
        }else {
            NotificationCenter.default.addObserver(self, selector: #selector(foregroundNotification), name: UIApplication.willEnterForegroundNotification, object: nil)
        }
    }
    
    @objc func foregroundNotification() {
        setTitleNDate()
        //setSuperView()
    }
    
    private func setTitleNDate() {
        calendar.locale = Locale(identifier: "ko")
        let comp = calendar.dateComponents([.month], from: date)
        month = comp.month ?? 0
        monthLabel.text = "\(month ?? 0)월"
    }
    
    //MARK:- setSuperView
    
    private func setSuperView() {
        addSubview(superScrollView)
        let constraint = superScrollView.fullConstraintsForAnchorsTo(view: self)
        NSLayoutConstraint.activate(constraint)
        
        self.superStackView.alignment = .fill
        self.superStackView.distribution = .fill
        self.superStackView.axis = .vertical
        self.superStackView.spacing = 5
        superScrollView.addSubview(superStackView)
        let stackConstraints = self.superStackView.fullConstraintsForAnchorsTo(view: superScrollView)
        NSLayoutConstraint.activate(stackConstraints)
        self.superStackView.widthAnchor.constraint(equalTo: self.superScrollView.widthAnchor).isActive = true
        
        monthLabel.text = "0월"
        monthLabel.textColor = UIColor(named: "calendarText")
        monthLabel.font = UIFont.boldSystemFont(ofSize: 25)
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.topView.addSubview(monthLabel)
        topView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        monthLabel.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor, constant: 10).isActive = true
        monthLabel.centerYAnchor.constraint(equalTo: self.topView.centerYAnchor).isActive = true
        
        let calenderView = setCalenderView()
        calenderView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        self.superStackView.addArrangedSubview(topView)
        self.superStackView.addArrangedSubview(calenderView)
    }
    
    //MARK:- setCalenderView
    
    private func setCalenderView() -> UIView {
        self.calenderStackView.axis = .vertical
        self.calenderStackView.alignment = .fill
        self.calenderStackView.distribution = .fillEqually
        self.calenderStackView.spacing = 0
        
        let dayStackView = setSubCalenderView() as! UIStackView
        setDayToStackView(sView: dayStackView)
        
        let oneStackView = setSubCalenderView() as! UIStackView
        let twoStackView = setSubCalenderView() as! UIStackView
        let threeStackView = setSubCalenderView() as! UIStackView
        let fourStackView = setSubCalenderView() as! UIStackView
        let fiveStackView = setSubCalenderView() as! UIStackView
        let sixStackView = setSubCalenderView() as! UIStackView
        setDayToLabel(one: oneStackView, two: twoStackView, three: threeStackView, four: fourStackView, five: fiveStackView, six: sixStackView)
        
        self.calenderStackView.addArrangedSubview(dayStackView)
        self.calenderStackView.addArrangedSubview(oneStackView)
        self.calenderStackView.addArrangedSubview(twoStackView)
        self.calenderStackView.addArrangedSubview(threeStackView)
        self.calenderStackView.addArrangedSubview(fourStackView)
        self.calenderStackView.addArrangedSubview(fiveStackView)
        self.calenderStackView.addArrangedSubview(sixStackView)
        
        return self.calenderStackView
    }
    
    private func setDayToStackView(sView : UIStackView) {
        let dayLabels = sView.arrangedSubviews as! [UILabel]
        let days = ["일","월", "화", "수", "목", "금", "토"]
        for i in 0...6 {
            dayLabels[i].text = days[i]
            dayLabels[i].textColor = .gray
        }
    }
    
    private func setDayToLabel(one : UIStackView, two : UIStackView, three : UIStackView, four : UIStackView, five : UIStackView, six : UIStackView) {
        guard let first = one.arrangedSubviews as? [UILabel] else {return}
        guard let second = two.arrangedSubviews as? [UILabel] else {return}
        guard let third = three.arrangedSubviews as? [UILabel] else {return}
        guard let fourth = four.arrangedSubviews as? [UILabel] else {return}
        guard let fifth = five.arrangedSubviews as? [UILabel] else {return}
        guard let sixth = six.arrangedSubviews as? [UILabel] else {return}
        let arr = [first, second, third, fourth, fifth, sixth].flatMap { $0 }
        let day = setFirstNLastDay()
        var number = 0
        
        for i in (day[1]-1)...(day[2]-1+day[1]-1){
            number+=1
            if number == today?.day {
                self.day = "\(today?.day ?? 0)"
                self.beforeDay = arr[i]
                self.todayLabel = arr[i]
                arr[i].isUserInteractionEnabled = true
                arr[i].layer.cornerRadius = 20
                arr[i].backgroundColor = UIColor(named: "calendarBack")
                arr[i].layer.masksToBounds = true
                arr[i].text = String(number)
                arr[i].textColor = UIColor(named: "BackGround")
                arr[i].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapDay(recognizer:))))
            }else {
                arr[i].isUserInteractionEnabled = true
                arr[i].text = String(number)
                arr[i].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapDay(recognizer:))))
            }
        }
        number = 0
        
    }
    
    @objc func tapDay(recognizer : UIGestureRecognizer) {
        
        impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        
        switch recognizer.state {
        case .began:
            impactFeedbackGenerator?.prepare()
        case .ended:
            impactFeedbackGenerator?.impactOccurred()
            impactFeedbackGenerator = nil
        default:
            break
        }
        let label = recognizer.view as? UILabel
        guard let presentDay = label else {fatalError("present Label is nil");}
        
        day = presentDay.text
 
        if let _day = day {
            delegate?.postDay?(data: Int(_day)!)
        }else {
            print("error")
        }
        
        delegate?.actionSegue?()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.beforeDay.layer.cornerRadius = 0
            self.beforeDay.layer.masksToBounds = true
            self.beforeDay.backgroundColor = UIColor.clear
            self.beforeDay.textColor = UIColor(named: "DefaultColor")
            if Int(presentDay.text!) != self.today!.day! {
                self.todayLabel?.textColor = UIColor(named: "calendarBack")
            }
        })
        self.beforeDay = presentDay
        UIView.animate(withDuration: 0.2) {
            if Int(presentDay.text!) == self.today!.day! {
                presentDay.layer.cornerRadius = 20
                presentDay.layer.masksToBounds = true
                presentDay.backgroundColor = UIColor(named: "calendarBack")
                presentDay.textColor = UIColor(named: "BackGround")
            }
            else {
                presentDay.layer.cornerRadius = 20
                presentDay.layer.masksToBounds = true
                presentDay.backgroundColor = UIColor(named: "DefaultColor")
                presentDay.textColor = UIColor(named: "BackGround")
            }
        }
    }
    
    private func setFirstNLastDay() -> [Int] {
        //여기에 기입하지 않은 날짜는 1로 초기화가 된다
        let components = calendar.dateComponents([.year, .month], from: date)
        //day를 기입하지 않아서 현재 달의 첫번쨰 날짜가 나오게 된다
        let startOfMonth = calendar.date(from: components)
        let comp1 = calendar.dateComponents([.day,.weekday,.weekOfMonth], from: startOfMonth!)
        //이번 달의 마지막 날짜를 구해주기 위해서 다음달을 구한다 이것도 day를 넣어주지 않았기 때문에 1이 다음달의 1일이 나오게 된다
        let nextMonth = calendar.date(byAdding: .month, value: +1, to: startOfMonth!)
        //위에 값에서 day값을 넣어주지 않았기 떄문에 1이 나오게 되므로 마지막 날을 알기 위해서 -1을 해준다
        let endOfMonth = calendar.date(byAdding: .day, value: -1, to:nextMonth!)
        
        let comp2 = calendar.dateComponents([.day,.weekday,.weekOfMonth], from: endOfMonth!)
        
        let arr = [comp1.day!, comp1.weekday!, comp2.day!, comp2.weekday!]
        
        return arr
    }
    
    private func setSubCalenderView() -> UIView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        stackView.addArrangedSubview(setDayView())
        stackView.addArrangedSubview(setDayView())
        stackView.addArrangedSubview(setDayView())
        stackView.addArrangedSubview(setDayView())
        stackView.addArrangedSubview(setDayView())
        stackView.addArrangedSubview(setDayView())
        stackView.addArrangedSubview(setDayView())
        
        return stackView
    }
    
    private func setDayView() -> UIView {
        let day = UILabel()
        day.textAlignment = .center
    
        return day
    }
}
