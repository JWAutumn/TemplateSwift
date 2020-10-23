//
//  DYCollectionViewController.swift
//  Whatever
//
//  Created by 帝云科技 on 2020/6/1.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import UIKit

class DYCollectionViewController: DYViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func dy_setupData() {
        super.dy_setupData()
        
    }
    
    override func dy_setupUI() {
        super.dy_setupUI()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(self.view.safeAreaLayoutGuide)
            } else {
                make.edges.equalToSuperview()
            }
        }
    }
    
    // MARK: - ConfigureData 初始化数据
    public func dy_configureData() {}
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .zero
        let collect = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collect.delegate = self
        collect.dataSource = self
        collect.emptyDataSetSource = self
        collect.emptyDataSetDelegate = self
        collect.backgroundColor = .custom(.section)
        if #available(iOS 11.0, *) {
            collect.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        collect.dy.register(cell: DYCollectionViewCell.self)
        collect.dy.register(header: UICollectionReusableView.self)
        collect.dy.register(footer: UICollectionReusableView.self)
        return collect
    }()
    
    lazy var datas: [[DYCollectionViewCellItem]] = {
        let datas = [[DYCollectionViewCellItem]]()
        return datas
    }()
    
    lazy var items0: [DYCollectionViewCellItem] = {
        let section = [DYCollectionViewCellItem]()
        return section
    }()
    
    lazy var items1: [DYCollectionViewCellItem] = {
        let section = [DYCollectionViewCellItem]()
        return section
    }()
    
    lazy var items2: [DYCollectionViewCellItem] = {
        let section = [DYCollectionViewCellItem]()
        return section
    }()
    
    lazy var items3: [DYCollectionViewCellItem] = {
        let section = [DYCollectionViewCellItem]()
        return section
    }()
    
    lazy var items4: [DYCollectionViewCellItem] = {
        let section = [DYCollectionViewCellItem]()
        return section
    }()
}


extension DYCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = datas[indexPath.section][indexPath.item]
        let cell = collectionView.dy.dequeue(cell: item.cellClass, for: indexPath) as! DYCollectionViewCell
        cell.item = item
        cell.delegate = self
        return cell
    }
}

extension DYCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout, layout.itemSize != .zero {
            return layout.itemSize
        }
        let item = datas[indexPath.section][indexPath.item]
        return item.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: UICollectionReusableView.self), for: indexPath)
        view.backgroundColor = .custom(.section)
        return view
    }
}

extension DYCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}


extension DYCollectionViewController: DYCollectionViewCellDelegate {
}
