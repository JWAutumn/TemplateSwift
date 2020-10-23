//
//  UICollectionViewExt.swift
//  Whatever
//
//  Created by 帝云科技 on 2020/6/2.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import UIKit


public extension DYSwiftWrapper where Base: UICollectionView {
    func register(cell: AnyClass) {
        base.register(cell, forCellWithReuseIdentifier: NSStringFromClass(cell))
    }
    
    func register(cells: AnyClass...) {
        cells.forEach { register(cell: $0) }
    }
    
    func register(header view: AnyClass) {
        base.register(view, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: NSStringFromClass(view))
    }
    
    func register(footer view: AnyClass) {
        base.register(view, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: NSStringFromClass(view))
    }
    
    func dequeue<T: UICollectionViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
        return base.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(cell), for: indexPath) as! T
    }
    
    func dequeue<T: UICollectionReusableView>(header view: T.Type, for indexPath: IndexPath) -> T {
        base.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                              withReuseIdentifier: NSStringFromClass(view), for: indexPath) as! T
    }
    
    func dequeue<T: UICollectionReusableView>(footer view: T.Type, for indexPath: IndexPath) -> T {
        base.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                              withReuseIdentifier: NSStringFromClass(view), for: indexPath) as! T
    }
}
