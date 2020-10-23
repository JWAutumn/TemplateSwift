//
//  DYCollectionViewCell.swift
//  Whatever
//
//  Created by 帝云科技 on 2020/6/2.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import UIKit

class DYCollectionViewCellItem: NSObject, DYCellItemProtocol {
    
    typealias T = UICollectionViewCell
    final public var cellIdentifier: String {
        let item = "Item"
        let clsName = NSStringFromClass(type(of: self))
        guard clsName.hasSuffix(item) else { return clsName }
        return String(clsName.prefix(clsName.count - item.count))
    }
    
    public var cellClass: T.Type {
        return NSClassFromString(self.cellIdentifier) as! T.Type
    }
    
    public var title: String?
    
    public var imageName: String?
    
    var selector: Selector?
    
    public var cellModel: DYModel?
    
    required public init(model: DYModel?) {
        self.cellModel = model
    }
    
    override init() {
    }
    
    public var cellSize: CGSize = .zero
    
}

// MARK: - DYCollectionViewCell
class DYCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: DYCollectionViewCellDelegate?
    
    var item: DYCollectionViewCellItem! {
        didSet {}
    }
    
    var separatorInset: UIEdgeInsets = .zero
    
    
    lazy var separatorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .custom(.section)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dy_setupViews()
        dy_setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dy_setupViews() {
        backgroundColor = .custom(.backgroundWhite)
        
        addSubview(separatorLabel)
        bringSubviewToFront(separatorLabel)
    }
    
    func dy_setupLayouts() {
        separatorLabel.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.separatorInset)
            make.height.equalTo(0.5)
        }
    }
}


