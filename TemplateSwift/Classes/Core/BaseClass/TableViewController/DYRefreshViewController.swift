//
//  DYRefreshViewController.swift
//  BaseSwift
//
//  Created by 帝云科技 on 2020/5/20.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import UIKit


private let defalutPage = "1"

class DYRefreshViewController: DYTableViewController {
    
    public var isAddRefreshHeader: Bool = true {
        didSet {
            self.reloadRefreshUI()
        }
    }
    
    public var isAddRefreshFooter: Bool = false {
        didSet {
            self.reloadRefreshUI()
        }
    }
    
    public var page: String = defalutPage
    
    public var pageCount: String? = defalutPage {
        didSet {
            if page >= pageCount ?? defalutPage {
                self.tableView.dy.footer?.endRefreshingWithNoMoreData()
            } else {
                self.tableView.dy.footer?.resetNoMoreData()
            }
        }
    }
    
    /// 是否执行了下拉刷新操作
    public var isDropDownRefresh: Bool {
        return page == defalutPage
    }
    
    override func dy_setupData() {
        super.dy_setupData()
        
    }
    
    override func dy_setupUI() {
        super.dy_setupUI()
        reloadRefreshUI()
    }
    
    // MARK: - public
    /// 刷新数据 子类中直接调用dy_requestData()即可
    public func dy_refreshData() {
        page = defalutPage
        dy_requestData()
    }
    
    /// 加载数据 子类中直接调用dy_requestData()即可
    public func dy_loadMoreData() {
        page = "\(Int(page)! + 1)"
        dy_requestData()
    }
    
    
    /// 停止刷新加载动画
    public final func dy_stopRefresh() {
        tableView.dy.endRefresh()
    }
    
    
    /// 下拉刷新时删除数据源
    public final func dy_refreshClearData() {
        dy_refreshClearData(data: &datas)
    }
    
    /// 下拉刷新时删除数据源
    /// - Parameter data: 数据源
    public final func dy_refreshClearData<T>(data: inout [T])  {
        guard isDropDownRefresh else { return }
        data.removeAll()
    }
    
    /// 更新列表UI
    public final func dy_tableViewReloadData() {
        dy_stopRefresh()
        tableView.reloadData()
        dy_hiddenFooter()
        if page >= pageCount ?? defalutPage {
            self.tableView.dy.footer?.endRefreshingWithNoMoreData()
        } else {
            self.tableView.dy.footer?.resetNoMoreData()
        }
    }
    
    // MARK: - private
    /// 判断是否隐藏footer
    private final func dy_hiddenFooter() {
        guard datas.count > 0 else {
            tableView.dy.footer?.isHidden = false
            return
        }
        let items = datas.first!
        tableView.dy.footer?.isHidden = items.count == 0
    }
}


extension DYRefreshViewController {
    fileprivate func reloadRefreshUI() {
        
        if !isAddRefreshHeader {
            tableView.dy.header = nil
        } else {
            tableView.dy.refreshHeader { [weak self] in
                self?.dy_refreshData()
            }
        }
        
        if !isAddRefreshFooter {
            tableView.dy.footer = nil
        } else {
            tableView.dy.refreshFooter { [weak self] in
                self?.dy_loadMoreData()
            }
        }
        
        dy_hiddenFooter()
    }
}
