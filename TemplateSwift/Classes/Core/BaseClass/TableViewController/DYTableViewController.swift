//
//  DYTableViewController.swift
//  BaseSwift
//
//  Created by 帝云科技 on 2019/6/28.
//  Copyright © 2019 帝云科技. All rights reserved.
//

import UIKit

class DYTableViewController: DYViewController {

    var style: UITableView.Style = .plain
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Base Class
    override func dy_setupData() {
        super.dy_setupData()
        
    }
    
    override func dy_setupUI() {
        super.dy_setupUI()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(self.view.safeAreaLayoutGuide)
            } else {
                make.edges.equalToSuperview()
            }
        }
    }
    
    // MARK: - ConfigureData 初始化数据
    func dy_configureData() -> Void {}
    func dy_configureData<T: DYModel>(model: T?) -> Void {}
    
    // MARK: - lazy
    lazy var tableView: UITableView =  {
        let table = UITableView.init(frame: CGRect(), style: style)
        table.dataSource = self
        table.delegate = self
        table.emptyDataSetSource = self
        table.emptyDataSetDelegate = self
        table.backgroundColor = .custom(.section)
        table.separatorStyle = .none
        table.tableFooterView = UIView()
        table.tableHeaderView = UIView.init(frame: CGRect.init(origin: .zero, size: CGSize(width: 1, height: CGFloat.leastNormalMagnitude)))
        table.estimatedSectionHeaderHeight = 0
        table.estimatedSectionFooterHeight = 0
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        table.dy.register(cell: DYTableViewCell.self)
        return table
    }()
    
    lazy var datas: [[DYTableViewCellItem]] = {
        let datas = [[DYTableViewCellItem]]()
        return datas
    }()
    
    lazy var items0: [DYTableViewCellItem] = {
        let section = [DYTableViewCellItem]()
        return section
    }()
    
    lazy var items1: [DYTableViewCellItem] = {
        let section = [DYTableViewCellItem]()
        return section
    }()
    
    lazy var items2: [DYTableViewCellItem] = {
        let section = [DYTableViewCellItem]()
        return section
    }()
    
    lazy var items3: [DYTableViewCellItem] = {
        let section = [DYTableViewCellItem]()
        return section
    }()
    
    lazy var items4: [DYTableViewCellItem] = {
        let section = [DYTableViewCellItem]()
        return section
    }()
}


extension DYTableViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = datas[indexPath.section][indexPath.row]
        let cell = tableView.dy.dequeue(cell: item.cellClass, for: indexPath) as! DYTableViewCell
        cell.item = item
        cell.delegate = self
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item: DYTableViewCellItem = datas[indexPath.section][indexPath.row]
        return item.cellHeight > 0 ? item.cellHeight : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .custom(.section)
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .custom(.section)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension DYTableViewController: DYTableViewCellDelegate {
}
