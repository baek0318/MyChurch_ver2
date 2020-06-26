//
//  CalanderViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/05/03.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

class CalanderViewController : UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var firstWeek: UIStackView!
    @IBOutlet weak var secondWeek: UIStackView!
    @IBOutlet weak var thirdWeek: UIStackView!
    @IBOutlet weak var fourthWeek: UIStackView!
    @IBOutlet weak var fifthWeek: UIStackView!
    @IBOutlet weak var sixthWeek: UIStackView!
    
    var date : Date?
    var calendar : Calendar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleNDate()
        makeCalendar()
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
        makeCalendar()
    }
}

//MARK:- Define Calendar

extension CalanderViewController {
    func setTitleNDate() {
        self.date = Date()
        self.calendar = Calendar(identifier: .gregorian)
        calendar?.locale = Locale(identifier: "ko")
        let comp = calendar?.dateComponents([.month], from: date!)
        self.navigationController?.navigationBar.topItem?.title = "\(comp?.month ?? 0)월"
    }
    
    func makeCalendar() {
        let first = firstWeek.arrangedSubviews as! [UILabel]
        let second = secondWeek.arrangedSubviews as! [UILabel]
        let third = thirdWeek.arrangedSubviews as! [UILabel]
        let fourth = fourthWeek.arrangedSubviews as! [UILabel]
        let fifth = fifthWeek.arrangedSubviews as! [UILabel]
        let sixth = sixthWeek.arrangedSubviews as! [UILabel]
        let arr = [first, second, third, fourth, fifth, sixth].flatMap { $0 }
        let day = firstNlastDay()
        let today = calendar?.dateComponents([.day], from: date!)
        var number = 0
        for i in (day[1]-1)...(day[2]-1+day[1]-1){
            number+=1
            if number == today?.day {
                arr[i].text = String(number)
                arr[i].textColor = UIColor(named: "calendarText")
            }else {
                arr[i].text = String(number)
            }
        }
        number = 0
    }
    
    func firstNlastDay() -> [Int] {
        //여기에 기입하지 않은 날짜는 1로 초기화가 된다
        let components = calendar?.dateComponents([.year, .month], from: date!)
        //day를 기입하지 않아서 현재 달의 첫번쨰 날짜가 나오게 된다
        let startOfMonth = calendar?.date(from: components!)!
        let comp1 = calendar?.dateComponents([.day,.weekday,.weekOfMonth], from: startOfMonth!)
        //이번 달의 마지막 날짜를 구해주기 위해서 다음달을 구한다 이것도 day를 넣어주지 않았기 때문에 1이 다음달의 1일이 나오게 된다
        let nextMonth = calendar?.date(byAdding: .month, value: +1, to: startOfMonth!)
        //위에 값에서 day값을 넣어주지 않았기 떄문에 1이 나오게 되므로 마지막 날을 알기 위해서 -1을 해준다
        let endOfMonth = calendar?.date(byAdding: .day, value: -1, to:nextMonth!)
        
        let comp2 = calendar?.dateComponents([.day,.weekday,.weekOfMonth], from: endOfMonth!)
        
        let arr = [comp1!.day!, comp1!.weekday!, comp2!.day!, comp2!.weekday!]
        
        return arr
    }
}


