//
//  MoreViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/14.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

class MoreViewController : UIViewController {
    
    @UserAutoLayout
    var superStackView = UIStackView()
    
    @UserAutoLayout
    var topBarStackView = UIStackView()
    
    @UserAutoLayout
    var mainView = UIScrollView()
    
    var tabBar : TabBarViewControl!
    
    var height : CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSuperStackView()
        deviceCheck()
        setSubView()
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
        
        let settingButton = UIButton()
        settingButton.setImage(UIImage(named: "setting"), for: .normal)
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        settingButton.heightAnchor.constraint(equalTo: settingButton.widthAnchor).isActive = true
        settingButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        topBarStackView.addArrangedSubview(self.tabBar)
        topBarStackView.addArrangedSubview(spacingView)
        topBarStackView.addArrangedSubview(settingButton)
        
        return self.topBarStackView
    }
    
    //MARK:- MainView
    
    func setMainView() -> UIView {
        self.mainView.contentSize.width = self.view.frame.width*3
        self.mainView.isPagingEnabled = true
        self.mainView.delegate = self
        
        return self.mainView
    }
    
    func setSubView() {
        let width = (self.mainView.contentSize.width-30)/3
        let view = CalendarView(frame: CGRect(x: 0, y: 0, width: width, height: height!))
        
        self.mainView.addSubview(view)
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
        self.mainView.contentOffset.x = self.view.frame.width*CGFloat(index)
    }
}
