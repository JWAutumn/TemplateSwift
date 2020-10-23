//
//  Api.swift
//  Whatever
//
//  Created by 帝云科技 on 2020/6/17.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import Foundation
import Moya


struct Api {
    #if DEBUG
    static let base = "http://xxx.com/"
    #else
    static let base = "http://xxx.com/"
    #endif
    
    static let baseApi = Api.base + "api/"
}

