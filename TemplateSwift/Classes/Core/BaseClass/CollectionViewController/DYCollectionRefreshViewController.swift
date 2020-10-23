//
//  DYCollectionRefreshViewController.swift
//  Whatever
//
//  Created by 帝云科技 on 2020/6/2.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import UIKit

private let defalutPage = "1"

class DYCollectionRefreshViewController: DYCollectionViewController, DYRefreshProtocol {
    
    
    var isAddRefreshHeader: Bool = true {
        didSet {
            reloadRefreshUI()
        }
    }
    
    var isAddRefreshFooter: Bool = false {
        didSet {
            reloadRefreshUI()
        }
    }
    
    var page: String = defalutPage
    
    var pageCount: String? = defalutPage {
        didSet {
            if page >= pageCount ?? defalutPage {
                self.collectionView.dy.footer?.endRefreshingWithNoMoreData()
            } else {
                self.collectionView.dy.footer?.resetNoMoreData()
            }
        }
    }
    
    var isDropDownRefresh: Bool {
        return page == defalutPage
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func dy_setupData() {
        super.dy_setupData()
        
    }
    
    override func dy_configureData() {
        
    }
    
    override func dy_setupUI() {
        super.dy_setupUI()
        reloadRefreshUI()
    }
    
    
    func dy_refreshData() {
        page = defalutPage
        dy_requestData()
    }
    
    func dy_loadMoreData() {
        page = "\(Int(page)! + 1)"
        dy_requestData()
    }
    
    func dy_stopRefresh() {
        collectionView.dy.endRefresh()
    }
    
    func dy_refreshClearData() {
        dy_refreshClearData(data: &datas)
    }
    
    func dy_refreshClearData<T>(data: inout [T])  {
        guard isDropDownRefresh else { return }
        data.removeAll()
    }
    
    func dy_viewReloadData() {
        dy_stopRefresh()
        collectionView.reloadData()
        dy_hiddenFooter()
        if page >= pageCount ?? defalutPage {
            self.collectionView.dy.footer?.endRefreshingWithNoMoreData()
        } else {
            self.collectionView.dy.footer?.resetNoMoreData()
        }
    }
    
    
    // MARK: - private
    /// 判断是否隐藏footer
    private final func dy_hiddenFooter() {
        guard datas.count > 0 else {
            collectionView.dy.footer?.isHidden = false
            return
        }
        let items = datas.first!
        collectionView.dy.footer?.isHidden = items.count == 0
    }
}


extension DYCollectionRefreshViewController {
    fileprivate func reloadRefreshUI() {
        
        if !isAddRefreshHeader {
            collectionView.dy.header = nil
        } else {
            collectionView.dy.refreshHeader { [weak self] in
                self?.dy_refreshData()
            }
        }
        
        if !isAddRefreshFooter {
            collectionView.dy.footer = nil
        } else {
            collectionView.dy.refreshFooter { [weak self] in
                self?.dy_loadMoreData()
            }
        }
    }
}

