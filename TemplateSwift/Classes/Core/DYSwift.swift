//
//  DYSwift.swift
//  BaseSwift
//
//  Created by 帝云科技 on 2020/5/26.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import Foundation


public struct DYSwiftWrapper<Base> {
    public var base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

/// 对象类型协议
/// 涉及到动态添加属性
public protocol DYSwiftCompatible: AnyObject { }

/// 值类型协议
public protocol DYSwiftCompatibleValue { }


extension DYSwiftCompatible {
    
    /// 调用成员方法
    public var dy: DYSwiftWrapper<Self> {
        get { return DYSwiftWrapper(self) }
        set { }
    }
    
    /// 调用静态方法
    static var dy: DYSwiftWrapper<Self>.Type {
        get { return DYSwiftWrapper<Self>.self }
        set { }
    }
}


extension DYSwiftCompatibleValue {
    
    public var dy: DYSwiftWrapper<Self> {
        get { return DYSwiftWrapper(self) }
        set { }
    }
    
    static var dy: DYSwiftWrapper<Self>.Type {
        get { return DYSwiftWrapper<Self>.self }
        set { }
    }
}


extension NSObject: DYSwiftCompatible { }
