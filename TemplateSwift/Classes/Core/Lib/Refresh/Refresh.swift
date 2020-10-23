//
//  Refresh.swift
//  InheritTableViewController
//
//  Created by 帝云科技 on 2020/5/19.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import UIKit

#if canImport(MJRefresh)
import MJRefresh

public extension DYSwiftWrapper where Base: UIScrollView {
    var header: MJRefreshHeader? {
        get { return base.mj_header }
        set { base.mj_header = newValue }
    }
    var footer: MJRefreshFooter? {
        get { return base.mj_footer }
        set { base.mj_footer = newValue}
    }
    
    func refreshHeader(_ closure: @escaping () -> Void) {
        base.mj_header = RefreshHeader(refreshingBlock: closure)
    }
    
    func refreshFooter(_ closure: @escaping () -> Void) {
        base.mj_footer = RefreshFooter(refreshingBlock: closure)
    }
    
    func endRefresh() {
        if let head = header, head.isRefreshing {
            head.endRefreshing()
        }
        if let foot = footer, foot.isRefreshing {
            foot.endRefreshing()
        }
    }
}


class RefreshHeader: MJRefreshNormalHeader {
    override func prepare() {
        super.prepare()
        
        setTitle("下拉刷新", for: .idle)
        setTitle("松开刷新", for: .pulling)
        setTitle("刷新数据中...", for: .refreshing)
        setTitle("刷新数据中...", for: .willRefresh)
        
        lastUpdatedTimeLabel?.isHidden = true
        stateLabel?.font = .systemFont(ofSize: 13)
        
        stateLabel?.textColor = .custom(.content)
        loadingView?.color = .custom(.content)

        if #available(iOS 13.0, *) {
            loadingView?.style = .medium
        }
    }
}


class RefreshFooter: MJRefreshAutoNormalFooter {
    override func prepare() {
        super.prepare()
        
        setTitle("点击或上拉加载", for: .idle)
        setTitle("松开加载", for: .pulling)
        setTitle("加载数据中...", for: .refreshing)
        setTitle("加载数据中...", for: .willRefresh)
        setTitle("已加载全部", for: .noMoreData)
        
        stateLabel?.font = .systemFont(ofSize: 13)
        stateLabel?.textColor = .custom(.content)
        loadingView?.color = .custom(.content)

        if #available(iOS 13.0, *) {
            loadingView?.style = .medium
        }
    }
}

#endif
