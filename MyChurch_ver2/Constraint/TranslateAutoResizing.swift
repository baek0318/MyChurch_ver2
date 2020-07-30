//
//  TranslateAutoResizing.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/07/30.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

///autolayout을 코드로 작성하기위한 translatesAutoresizingMaskIntoConstraints를 false로 설정해주는 property wrapper이다
@propertyWrapper
struct UserAutoLayout<T : UIView> {
    
    public var wrappedValue : T {
        didSet {
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    public init(wrappedValue : T) {
        self.wrappedValue = wrappedValue
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
