//
//  OptionalExt.swift
//  Whatever
//
//  Created by 帝云科技 on 2020/7/22.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import Foundation

extension Optional {
    var isNone: Bool {
           switch self {
           case .none:
               return true
           case .some:
               return false
           }
       }
       
       var isSome: Bool {
           return !isNone
       }
}
