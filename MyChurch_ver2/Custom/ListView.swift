//
//  ListView.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/05/07.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

class ListView : UIView {
    
    func makeStackView() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        self.addSubview(stack)
        makeListView(main: "찬양", sub: "다같이", tall: 35)
        makeListView(main: "신앙고백", sub: "사도신경", tall: 125)
        makeListView(main: "교독문", sub: "58", tall: 215)
        makeListView(main: "기도", sub: "성낙율 장로", tall: 305)
        makeListView(main: "헌금", sub: "실내악기팀", tall: 395)
        makeListView(main: "본문", sub: "고후 6:1-13", tall: 485)
        makeListView(main: "설교 \\ 정명철 목사", sub: "은혜 받은 자의 복된 마음", tall: 575)
        makeListView(main: "축도", sub: "정명철 목사", tall: 665)
    }
    
    func makeListView(main : String, sub : String, tall : CGFloat) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 330, height: 80))
        view.center = CGPoint(x: self.frame.width/2, y: tall)
        view.backgroundColor = UIColor(named: "moreButton")
        view.layer.cornerRadius = CGFloat(10)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .init(width: 0.5, height: 1)
        view.layer.masksToBounds = false
        self.addSubview(view)
        
        let title = UILabel(frame: CGRect(x: 0, y: 50, width: 300, height: 40))
        title.center = CGPoint(x: view.frame.width/2, y: 20)
        title.textColor = .darkGray
        title.font = .boldSystemFont(ofSize: 19)
        title.text = main
        title.textAlignment = .left
        let subTitle = UILabel(frame: CGRect(x: 0, y: 95, width: 300, height: 40))
        subTitle.center = CGPoint(x: view.frame.width/2, y: 60)
        subTitle.font = .boldSystemFont(ofSize: 21)
        subTitle.textAlignment = .right
        subTitle.text = sub
        
        let divideBar = UIView(frame: CGRect(x: 0, y: 70, width: 2, height: self.frame.height))
        divideBar.center = CGPoint(x: self.frame.width/2, y: 70)
        divideBar.backgroundColor = .init(red: CGFloat(0.2), green: CGFloat(0.44), blue: CGFloat(0.878), alpha: 1.0)
        
        view.addSubview(title)
        view.addSubview(subTitle)
        
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = UIColor.clear
        self.makeStackView()
    }
}
