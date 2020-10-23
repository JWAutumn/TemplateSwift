//
//  DYRefreshProtocol.swift
//  Whatever
//
//  Created by 帝云科技 on 2020/6/2.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import Foundation

protocol DYRefreshProtocol: class {
    
    /// 添加头部刷新
    var isAddRefreshHeader: Bool { get set }
    /// 添加尾部刷新
    var isAddRefreshFooter: Bool { get set }
    /// 页码
    var page: String { get set }
    /// 总页数
    var pageCount: String? { get set }
    
    /// 是否进行了下拉刷新
    var isDropDownRefresh: Bool { get }
    
    /// 下拉刷新
    func dy_refreshData()
    /// 加载更多
    func dy_loadMoreData()
    
    /// 停止刷新
    func dy_stopRefresh()
    
    /// 刷新当前列表
    func dy_viewReloadData()
}



extension DYRefreshProtocol where Self: DYCollectionRefreshViewController {
    
}

extension DYRefreshProtocol where Self: DYRefreshViewController {
    
}
