//
//  CalendarView.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/14.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

class CalendarView : UIView {
    
    @UserAutoLayout
    var superScrollView = UIScrollView()
    
    @UserAutoLayout
    var topView = UIView()
    
    @UserAutoLayout
    var superStackView = UIStackView()
    
    @UserAutoLayout
    var calenderStackView = UIStackView()
    
    @UserAutoLayout
    var monthLabel = UILabel()
    
    var calendar = Calendar(identifier: .gregorian)
    
    let date = Date()
    
    var day : String?
    
    var month : Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setSuperView()
        self.setTitleNDate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func makeNotification() {
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
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        guard let dv = segue.destination as? DayViewController else {return}
        dv.dateTitle = "\(month ?? 0)월 \(day ?? "0")일"
    }
    */
    func setTitleNDate() {
        calendar.locale = Locale(identifier: "ko")
        let comp = calendar.dateComponents([.month], from: date)
        month = comp.month ?? 0
        monthLabel.text = "\(month ?? 0)월"
        //self.navigationController?.navigationBar.topItem?.title = "\(comp.month ?? 0)월"
    }
    
    //MARK:- setSuperView
    
    func setSuperView() {
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
        monthLabel.textColor = .gray
        monthLabel.font = UIFont.boldSystemFont(ofSize: 30)
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.topView.addSubview(monthLabel)
        topView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        monthLabel.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor, constant: 10).isActive = true
        monthLabel.centerYAnchor.constraint(equalTo: self.topView.centerYAnchor).isActive = true
        
        let calenderView = setCalenderView()
        calenderView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        let otherView = setOtherView()
        otherView.translatesAutoresizingMaskIntoConstraints = false
        otherView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        
        self.superStackView.addArrangedSubview(topView)
        self.superStackView.addArrangedSubview(calenderView)
        self.superStackView.addArrangedSubview(otherView)
    }
    
    //MARK:- setCalenderView
    
    func setCalenderView() -> UIView {
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
    
    func setDayToStackView(sView : UIStackView) {
        let dayLabels = sView.arrangedSubviews as! [UILabel]
        let days = ["일","월", "화", "수", "목", "금", "토"]
        for i in 0...6 {
            dayLabels[i].text = days[i]
            dayLabels[i].textColor = .gray
        }
    }
    
    func setDayToLabel(one : UIStackView, two : UIStackView, three : UIStackView, four : UIStackView, five : UIStackView, six : UIStackView) {
        guard let first = one.arrangedSubviews as? [UILabel] else {return}
        guard let second = two.arrangedSubviews as? [UILabel] else {return}
        guard let third = three.arrangedSubviews as? [UILabel] else {return}
        guard let fourth = four.arrangedSubviews as? [UILabel] else {return}
        guard let fifth = five.arrangedSubviews as? [UILabel] else {return}
        guard let sixth = six.arrangedSubviews as? [UILabel] else {return}
        let arr = [first, second, third, fourth, fifth, sixth].flatMap { $0 }
        let day = setFirstNLastDay()
        let today = calendar.dateComponents([.day], from: date)
        var number = 0
        
        for i in (day[1]-1)...(day[2]-1+day[1]-1){
            number+=1
            if number == today.day {
                self.day = "\(today.day ?? 0)"
                arr[i].isUserInteractionEnabled = true
                arr[i].text = String(number)
                arr[i].textColor = UIColor(named: "calendarText")
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
        let label = recognizer.view as? UILabel
        day = label?.text
        print("run")
        //performSegue(withIdentifier: "DatePick", sender: nil)
    }
    
    func setFirstNLastDay() -> [Int] {
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
    
    func setSubCalenderView() -> UIView {
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
    
    func setDayView() -> UIView {
        let day = UILabel()
        day.textAlignment = .center
        
        return day
    }
    
    //MARK:- setOtherView
    
    func setOtherView() -> UIView {
        let otherView = UIView()
        otherView.backgroundColor = .gray
        
        let label = UILabel()
        label.text = "peachberry"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        otherView.addSubview(label)
        otherView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 5).isActive = true
        label.centerXAnchor.constraint(equalTo: otherView.centerXAnchor).isActive = true
        
        return otherView
    }
    
}
