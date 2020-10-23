//
//  UIImageViewExt.swift
//  Whatever
//
//  Created by 帝云科技 on 2020/7/17.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import UIKit

public extension DYSwiftWrapper where Base: UIImageView {
    
    func scaleAspectFill() {
        base.contentMode = .scaleAspectFill
        base.clipsToBounds = true
    }
    
}
