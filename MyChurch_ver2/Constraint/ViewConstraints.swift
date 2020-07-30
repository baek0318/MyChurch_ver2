//
//  ViewConstraints.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/07/30.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

//MARK:- UIView about Constraint

extension UIView {
    
    func safeAreaConstraintsForAnchorsTo(view : UIView) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
    }
    
    func eachSafeAreaConstraintsForAnchorsTo(view : UIView, top topCons: CGFloat, leading leadingCons: CGFloat, bottom bottomCons: CGFloat, trailing trailingCons: CGFloat) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topCons),
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leadingCons),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomCons),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingCons)
        ]
    }
    
    ///여기에서 view parameter는 상위 view라고 볼 수 있다
    ///상위 view에 대하여 constraint를 0으로 해서 적용할 수 있는 메서드
    func fullConstraintsForAnchorsTo(view : UIView) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
    }
    
    ///상위 view에 대하여 constraint를 개별적으로 적용할 수 있는 메서드
    func eachConstraintsForAnchorsTo(view : UIView, top topCons: CGFloat, leading leadingCons: CGFloat, bottom bottomCons: CGFloat, trailing trailingCons: CGFloat) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: view.topAnchor, constant: topCons),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingCons),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomCons),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingCons)
        ]
    }
    
}


