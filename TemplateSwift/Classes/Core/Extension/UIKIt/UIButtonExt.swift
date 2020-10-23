//
//  UIButtonExt.swift
//  BaseSwift
//
//  Created by 帝云科技 on 2020/5/26.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import UIKit



public extension DYSwiftWrapper where Base: UIButton {
    
    enum Position {
        case above, left, bottom, right
    }
    
    func set(image position: Position = .left, spacing: CGFloat) {
        base.layoutIfNeeded()
        
        guard
            let imageWidth = base.imageView?.frame.width,
            let imageHeight = base.imageView?.frame.height,
            let titleWidth = base.titleLabel?.frame.width,
            let titleHeight = base.titleLabel?.frame.height
        else { return }
        
        let space = spacing * 0.5
        
        let imageOffsetX = (imageWidth + titleWidth) / 2 - imageWidth / 2
        let imageOffsetY = imageHeight / 2 + space
        let titleOffsetX = (imageWidth + titleWidth / 2) - (imageWidth + titleWidth) / 2
        let titleOffsetY = titleHeight / 2 + spacing
        
        switch position {
        case .left:
            base.imageEdgeInsets = UIEdgeInsets(top: 0, left: -space, bottom: 0, right: space)
            base.titleEdgeInsets = UIEdgeInsets(top: 0, left: space, bottom: 0, right: -space)
        case .right:
            base.imageEdgeInsets = UIEdgeInsets(top: 0, left: space + titleWidth, bottom: 0, right: -(space + titleWidth))
            base.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(space + titleWidth), bottom: 0, right: (space + titleWidth))
        case .above:
            base.imageEdgeInsets = UIEdgeInsets(top: -imageOffsetY, left: imageOffsetX, bottom: imageOffsetY, right: -imageOffsetX)
            base.titleEdgeInsets = UIEdgeInsets(top: titleOffsetY, left: -titleOffsetX, bottom: -titleOffsetY, right: titleOffsetX)
        case .bottom:
            base.imageEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: imageOffsetX, bottom: -imageOffsetY, right: -imageOffsetX)
            base.titleEdgeInsets = UIEdgeInsets(top: -titleOffsetY, left: -titleOffsetX, bottom: titleOffsetY, right: titleOffsetX)
        }
    }
    
}
