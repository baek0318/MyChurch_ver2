//
//  CalendarTableView.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/17.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit
import Firebase

class CalendarTableView: UIView {
    
    private var calendarTable : UITableView!
    
    private var today : Int?
    
    @UserAutoLayout
    private var dayPlanLabel = UILabel()
    
    private var switchTap : Bool?
    
    var scheduledData = [Dictionary<String, String>]()
    
    convenience init(frame : CGRect, day : Int) {
        self.init(frame: frame)
        self.today = day
        setCalendarTableView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
    }
    
    private func setCalendarTableView() {
        self.backgroundColor = UIColor(named: "BackGround")
        self.calendarTable = UITableView(frame: CGRect(x: 0, y: 50, width: self.frame.width, height: self.frame.height-50))
        self.calendarTable.delegate = self
        self.calendarTable.dataSource = self

        addSubview(self.calendarTable)
        self.calendarTable.tableFooterView = UIView()
        
        let dayLabel = UILabel()
        dayLabel.text = "\(today ?? 0)일 이벤트"
        dayLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(dayLabel)
        dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
    }
    
    ///날짜를 tap한 경우 해당 날짜의 이벤트를 reload할 수 있는 함수
    func setReloadData() {
        UIView.animate(withDuration: 0.3, animations: {
            self.calendarTable.alpha = 0.3
        }) { (_) in
            UIView.animate(withDuration: 0.3) {
                self.calendarTable?.alpha = 1.0
            }
            self.calendarTable.reloadData()
        }
    }
    
    ///오늘 날짜를 파악하기위한 함수
    func setToday(newDay : Int) {
        self.today = newDay
    }
    
    func getTableView() -> UITableView {
        return self.calendarTable
    }
}

extension CalendarTableView : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduledData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let data = scheduledData[indexPath.row]
        
        let cell = calendarTable?.dequeueReusableCell(withIdentifier: "CalendarCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "CalendarCell")
            
        cell.textLabel?.text = data["title"]?.replacingOccurrences(of: "\\n", with: "\n")
        cell.detailTextLabel?.text = data["time"]?.replacingOccurrences(of: "\\n", with: "\n")
        cell.detailTextLabel?.textColor = .gray
            
        return cell

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        
        let label = UILabel()
        label.backgroundColor = UIColor(named: "BackGround")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(tableView.numberOfRows(inSection: 0))개의 이벤트"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .gray
        
        view.addSubview(label)
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        
        return view
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

