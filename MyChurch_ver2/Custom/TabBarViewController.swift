//
//  TabBarViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/14.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

protocol TabBarViewControlDelegate {
    func pageChange(index : Int)
}

class TabBarViewControl : UIView {
    //필요한 모델들의 변수를 선언하여 준다
    private var buttonTitles : [String]!
    private var buttons : [UIButton]!
    private var selectorView : UIView!

    private var tabStackView : UIStackView!
    
    var delegate : TabBarViewControlDelegate?
    
    //글자의 원래 색과 선택되었을때의 view와 글자의 색상을 바꿔준다
    var selectedIndex : Int = 0
    var textColor : UIColor! = UIColor(named: "darkmode")
    var selectorViewColor : UIColor = UIColor(named: "DefaultColor")!
    var selectorTextColor : UIColor = UIColor(named: "DefaultColor")!
    
    convenience init( buttonTitle:[String]){
        self.init()
        self.buttonTitles = buttonTitle
    }
    
    //stack뷰를 구성하는을 설정해주고 레이아웃을 잡아주는 단계
    private func configStackView() {
        tabStackView = UIStackView(arrangedSubviews: buttons)
        tabStackView.axis = .horizontal
        tabStackView.alignment = .leading
        tabStackView.distribution = .fill
        tabStackView.spacing = 10
        tabStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tabStackView)
        let constraints = tabStackView.fullConstraintsForAnchorsTo(view: self)
        NSLayoutConstraint.activate(constraints)
    }
    
    //selectorView 만들어주는 곳
    private func configSelectorView() {
        let selectorWidth : CGFloat = buttons[selectedIndex].intrinsicContentSize.width
        var presentPointX : CGFloat = frame.width/CGFloat(buttonTitles.count)*CGFloat(selectedIndex)
        
        var selectorPosition = buttons[selectedIndex].intrinsicContentSize.width*(CGFloat(selectedIndex))
        if selectedIndex == buttons.count-1 {
            selectorPosition = buttons[selectedIndex].intrinsicContentSize.width*(CGFloat(selectedIndex-1))
        }
        if selectedIndex == 1 {
            presentPointX = selectorPosition+10
        }else {
            presentPointX = selectorPosition
        }
        selectorView = UIView(frame: CGRect(x: presentPointX, y: self.frame.height+10, width: selectorWidth, height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }

    //button을 만들어 주는곳
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview()}
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
            button.addTarget(self, action: #selector(TabBarViewControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(UIColor(named: "tabText"), for: .normal)
            buttons.append(button)
        }
        buttons[self.selectedIndex].setTitleColor(selectorTextColor, for: .normal)
    }
    
    //button의 액션을 정의해 주는 곳
    @objc func buttonAction(sender:UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(UIColor(named: "tabText"), for: .normal)
            if btn == sender  {
                selectedIndex = buttonIndex
                delegate?.pageChange(index: selectedIndex)
                var selectorPosition = btn.intrinsicContentSize.width*(CGFloat(buttonIndex))
                if buttonIndex == buttons.count-1 {
                    selectorPosition = btn.intrinsicContentSize.width*(CGFloat(buttonIndex-1))
                }
                UIView.animate(withDuration: 0.1) {
                    if buttonIndex == 1 {
                        self.selectorView.frame.origin.x = selectorPosition+10
                        self.selectorView.frame.size.width = btn.intrinsicContentSize.width
                    }else {
                        self.selectorView.frame.origin.x = selectorPosition
                        self.selectorView.frame.size.width = btn.intrinsicContentSize.width
                    }
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
    
    func selectorAction(index : Int) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(UIColor(named: "tabText"), for: .normal)
            if buttonIndex == index  {
                selectedIndex = buttonIndex
                var selectorPosition = btn.intrinsicContentSize.width*(CGFloat(buttonIndex))
                if buttonIndex == buttons.count-1 {
                    selectorPosition = btn.intrinsicContentSize.width*(CGFloat(buttonIndex-1))
                }
                UIView.animate(withDuration: 0.1) {
                    if buttonIndex == 1 {
                        self.selectorView.frame.origin.x = selectorPosition+10
                        self.selectorView.frame.size.width = btn.intrinsicContentSize.width
                    }else {
                        self.selectorView.frame.origin.x = selectorPosition
                        self.selectorView.frame.size.width = btn.intrinsicContentSize.width
                    }
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
    
    //view 업데이트 하는곳
    private func updateView() {
        createButton()
        configSelectorView()
        configStackView()
    }
    
    //
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = .clear
        updateView()
    }
}


