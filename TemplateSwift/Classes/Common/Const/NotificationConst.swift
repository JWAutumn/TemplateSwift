//
//  NotificationConst.swift
//  Whatever
//
//  Created by 帝云科技 on 2020/6/28.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import Foundation


enum DYNotification: String {
    case login, logout
    
    var value: String {
        return "DY" + rawValue
    }
    
    var notificationName: Notification.Name {
        return Notification.Name(value)
    }
    
}


extension NotificationCenter {
    static func addObserver(dy observer: Any, selector: Selector, name: DYNotification, object: Any?) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: name.notificationName, object: object)
    }
    
    static func post(dy name: DYNotification, object: Any? = nil) {
        NotificationCenter.default.post(name: name.notificationName, object: object)
    }
    
    static func removeObserver(dy observer: Any) {
        NotificationCenter.default.removeObserver(observer)
    }
}

