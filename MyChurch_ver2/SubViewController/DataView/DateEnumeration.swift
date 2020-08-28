//
//  DateEnumeration.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/28.
//  Copyright © 2020 백승화. All rights reserved.
//

import Foundation

enum DayStringToInt : String {
    case one = "1일"
    case two = "2일"
    case three = "3일"
    case four = "4일"
    case five = "5일"
    case six = "6일"
    case seven = "7일"
    case eight = "8일"
    case nine = "9일"
    case ten = "10일"
    case eleven = "11일"
    case twelve = "12일"
    case thirteen = "13일"
    case fourteen = "14일"
    case fifteen = "15일"
    case sixteen = "16일"
    case eventeen = "17일"
    case eighteen = "18일"
    case nineteen = "19일"
    case twenty = "20일"
    case twentyone = "21일"
    case twentytwo = "22일"
    case twentythree = "23일"
    case twentyfour = "24일"
    case twentyfive = "25일"
    case twnetysix = "26일"
    case twentyseven = "27일"
    case twnetyeight = "28일"
    case twentynine = "29일"
    case thirty = "30일"
    case thirtyone = "31일"
    
    func StringToInt() -> Int {
        switch  self{
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        case .five:
            return 5
        case .six:
            return 6
        case .seven:
            return 7
        case .eight:
            return 8
        case .nine:
            return 9
        case .ten:
            return 10
        case .eleven:
            return 11
        case .twelve:
            return 12
        case .thirteen:
            return 13
        case .fourteen:
            return 14
        case .fifteen:
            return 15
        case .sixteen:
            return 16
        case .eventeen:
            return 17
        case .eighteen:
            return 18
        case .nineteen:
            return 19
        case .twenty:
            return 20
        case .twentyone:
            return 21
        case .twentytwo:
            return 22
        case .twentythree:
            return 23
        case .twentyfour:
            return 24
        case .twentyfive:
            return 25
        case .twnetysix:
            return 26
        case .twentyseven:
            return 27
        case .twnetyeight:
            return 28
        case .twentynine:
            return 29
        case .thirty:
            return 30
        case .thirtyone:
            return 31
        }
    }
}

enum MonthStringToInt : String {
    case one = "1월"
    case two = "2월"
    case three = "3월"
    case four = "4월"
    case five = "5월"
    case six = "6월"
    case seven = "7월"
    case eight = "8월"
    case nine = "9월"
    case ten = "10월"
    case eleven = "11월"
    case twelve = "12월"
    
    func StringToInt() -> Int {
        switch self {
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        case .five:
            return 5
        case .six:
            return 6
        case .seven:
            return 7
        case .eight:
            return 8
        case .nine:
            return 9
        case .ten:
            return 10
        case .eleven:
            return 11
        case .twelve:
            return 12
        }
    }
}

enum Kind : String {
    case evening, morning, wednesday
    
    func korean() -> String {
        switch self {
        case .evening:
            return "오후 예배"
        case .morning:
            return "오전 예배"
        case .wednesday:
            return "수요 예배"
        }
    }
}

