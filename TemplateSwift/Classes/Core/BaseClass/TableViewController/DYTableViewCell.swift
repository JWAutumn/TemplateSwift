//
//  DYTableViewCell.swift
//  BaseSwift
//
//  Created by 帝云科技 on 2019/6/6.
//  Copyright © 2019 帝云科技. All rights reserved.
//

import UIKit

// MARK: - DYTableViewCellItem
class DYTableViewCellItem: NSObject, DYCellItemProtocol {
    typealias T = UITableViewCell
    final public var cellIdentifier: String {
        let item = "Item"
        let clsName = NSStringFromClass(type(of: self))
        guard clsName.hasSuffix(item) else { return clsName }
        return String(clsName.prefix(clsName.count - item.count))
    }
    
    final public var cellClass: T.Type {
        return NSClassFromString(self.cellIdentifier) as! T.Type
    }
    
    public var title: String?
    
    public var imageName: String?
    
    public var selector: Selector?
    
    public var cellModel: DYModel?
    
    required public init(model: DYModel?) {
        self.cellModel = model
    }
    
    override init() {}
    
    
    public var cellHeight: CGFloat = 0
    
    public var isShowIndicator: Bool = false
    
}


// MARK: - DYTableViewCell
class DYTableViewCell: UITableViewCell {
    
    weak var delegate: DYTableViewCellDelegate?
    
    var item: DYTableViewCellItem! {
        didSet {
            guard let item = item else { return }
            guard item.isMember(of: DYTableViewCellItem.self) else { return }
            
            self.textLabel?.text = item.title
            if let imageName = item.imageName {
                self.imageView?.image = UIImage(named: imageName)
            } else {
                self.imageView?.image = nil
            }
            
            if item.selector != nil {
                self.addGestureRecognizer(self.tapRecognizer)
            } else {
                self.removeGestureRecognizer(self.tapRecognizer)
            }
            
            if accessoryType == .none, accessoryView == nil {
                accessoryType = item.isShowIndicator ? .disclosureIndicator : .none
            }
        }
    }
    
    lazy var separatorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .custom(.line)
        return label
    }()
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
        return tap
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dy_setupViews()
        dy_setupLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func dy_setupViews() -> Void {
        layoutMargins = .zero
        separatorInset = UIEdgeInsets(top: 0, left: CellPadding, bottom: 0, right: CellPadding)
        backgroundColor = .custom(.backgroundWhite)
        textLabel?.textColor = .custom(.title)
        textLabel?.font = .systemFont(ofSize: 15)
        
        addSubview(separatorLabel)
    }
    
    public func dy_setupLayouts() {
        separatorLabel.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.separatorInset)
            make.height.equalTo(0.5)
        }
        bringSubviewToFront(separatorLabel)
    }
    
    @objc private func tapGestureAction() {
        guard
            let selector = item.selector,
            let controller = dy.currentController,
            controller.responds(to: selector)
        else { return }
        controller.perform(selector)
    }
}



extension Array where Element == [DYTableViewCellItem] {
    func item(for title: String) -> DYTableViewCellItem? {
        for items in self {
            if let item = items.item(for: title) {
                return item
            }
        }
        return nil
    }
}

extension Array where Element == DYTableViewCellItem {
    func item(for title: String) -> DYTableViewCellItem? {
        for item in self {
            if item.title == title {
                return item
            }
        }
        return nil
    }
}
