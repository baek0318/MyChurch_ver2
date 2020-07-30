//
//  WebLiveGet.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/07/18.
//  Copyright © 2020 백승화. All rights reserved.
//

import Foundation
import WebKit

struct WebLiveGet {

    static func loadVideo(url : String) -> URLRequest {
        let videoURL = URL(string: url)!
        let request = URLRequest(url: videoURL)
        return request
    }
    
}
