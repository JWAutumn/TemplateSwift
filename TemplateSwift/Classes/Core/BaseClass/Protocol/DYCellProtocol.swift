//
//  DYCellProtocol.swift
//  Whatever
//
//  Created by 帝云科技 on 2020/6/2.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import Foundation
import UIKit


protocol DYCellItemProtocol {
    associatedtype T
    
    var cellIdentifier: String { get }
    var cellClass: T.Type { get }
    var cellModel: DYModel? { get set }
    var selector: Selector? { get set }
    
    init(model: DYModel?)
    
    var title: String? { get set }
    var imageName: String? { get set }
}



@objc protocol DYTableViewCellDelegate {
    @objc optional func dy_responseViewInCell(_ cell: DYTableViewCell, object: Any?)
}

@objc protocol DYCollectionViewCellDelegate {
    @objc optional func dy_responseViewInCell(_ cell: DYCollectionViewCell, object: Any?)
}
