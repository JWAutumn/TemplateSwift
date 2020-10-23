//
//  DYView.swift
//  BaseSwift
//
//  Created by 帝云科技 on 2020/5/22.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import UIKit


class DYView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dy_setupViews()
        dy_setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func dy_setupViews()  {
        backgroundColor = .custom(.backgroundWhite)
    }
    
    public func dy_setupLayouts() {
        
    }
    
}
