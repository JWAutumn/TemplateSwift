//
//  ApiTargetType.swift
//  Whatever
//
//  Created by 帝云科技 on 2020/6/18.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import Foundation
import Moya

/// 加载框
///
///     normal：正常，默认
///     opaque：不透明背景
///     text：带加载文字
///     none：隐藏
///
public enum Loading {
    case normal
    case opaque
    case text(text: String)
    case none
}


public protocol ApiTargetType: TargetType {
    
    /// 参数
    var parameters: [String: Any]? { get }
    
    /// 加载框
    var showLoading: Loading { get }
    /// 加载父视图
    var loadingInView: UIView? { get }
    
    /// 是否使用token
    var useToken: Bool { get }
}

extension ApiTargetType {
    
    public var baseURL: URL {
        return URL(string: Api.baseApi)!
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var parameters: [String: Any]? {
        return [:]
    }
    
    public var showLoading: Loading {
        return .normal
    }
    
    /// 做测试使用
    public var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    public var task: Task {
        let encoding: ParameterEncoding
        switch self.method {
        case .post:
            encoding = JSONEncoding.default
        default:
            encoding = URLEncoding.default
        }
        
        if let parameters = self.parameters {
            return .requestParameters(parameters: parameters, encoding: encoding)
        }
        return .requestPlain
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var loadingInView: UIView? {
        return UIViewController.dy.currentController()?.view
    }
    
    public var useToken: Bool {
        return true
    }
}
