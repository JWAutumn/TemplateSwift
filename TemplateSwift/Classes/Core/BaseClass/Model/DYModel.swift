//
//  DYModel.swift
//  BaseSwift
//
//  Created by 帝云科技 on 2020/5/22.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import Foundation

#if canImport(HandyJSON)
@_exported import HandyJSON

class DYModel: NSObject, HandyJSON {
    public required override init() {}
    
    func mapping(mapper: HelpingMapper) { }
    func didFinishMapping() { }
}


// MARK: - Json to model
extension DYModel {
    
    static func toModel(_ list: NSDictionary?) -> Self? {
        guard let list = list else { return nil }
        return Self.deserialize(from: list)
    }
    
    static func toModels(_ lists: NSArray?) -> [DYModel]? {
        guard let lists = lists else { return nil }
        return [Self].deserialize(from: lists) as? [Self]
    }
    
    static func toModels<T: DYModel>(_ lists: Any?) -> [T]? {
        return [Self].deserialize(from: lists as? NSArray) as? [T]
    }
}

#else
class DYModel: NSObject { }
#endif


