//
//  UITableViewExt.swift
//  BaseSwift
//
//  Created by 帝云科技 on 2020/5/27.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import UIKit

public extension DYSwiftWrapper where Base: UITableView {
    func register(cell: AnyClass) {
        base.register(cell, forCellReuseIdentifier: NSStringFromClass(cell))
    }
    
    func register(cells: AnyClass...) {
        cells.forEach { register(cell: $0) }
    }
    
    func register(view: AnyClass) {
        base.register(view, forHeaderFooterViewReuseIdentifier: NSStringFromClass(view))
    }
    
    func dequeue<T: UITableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
        return base.dequeueReusableCell(withIdentifier: NSStringFromClass(cell), for: indexPath) as! T
    }
    
    func dequeue<T: UITableViewHeaderFooterView>(view: T.Type) -> T {
        return base.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(view)) as! T
    }
}
