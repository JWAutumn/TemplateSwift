//
//  ArrayExt.swift
//  BaseSwift
//
//  Created by 帝云科技 on 2020/5/29.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import Foundation

extension Array: DYSwiftCompatibleValue {}

extension DYSwiftWrapper where Base == Array<Any> {
    
}

public extension Array {
    subscript(safe index: Int) -> Element? {
        return count > index ? self[index] : nil
    }
}


