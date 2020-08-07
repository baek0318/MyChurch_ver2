//
//  DeviceAdjustSize.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/07.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

class DeviceAdjustSize {
    
    func searchDevice() {
        if UIDevice().userInterfaceIdiom == .phone {
          switch UIScreen.main.nativeBounds.height {
            case 1136:
            //"iPhone se"
            break
            case 1334:
            //"iPhone 6/6S/7/8"
            break
            case 2208:
            //"iPhone 6+/6S+/7+/8+"
            break
            case 2436:
            //"iPhone X"
            break
            case 2688:
            //"iPhone 11pro Max"
            break
            case 1792:
            //"iPhone 11/Xr"
            break
            default:
            print("unknown")
          }
        }
    }
    
}
