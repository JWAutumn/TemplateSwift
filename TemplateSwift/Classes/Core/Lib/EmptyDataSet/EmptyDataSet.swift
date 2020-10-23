//
//  EmptyDataSet.swift
//  BaseSwift
//
//  Created by 帝云科技 on 2020/5/21.
//  Copyright © 2020 帝云科技. All rights reserved.
//

#if canImport(DZNEmptyDataSet)
import DZNEmptyDataSet


private var EmptyDataSetTitleKey: Void?
private var EmptyDataSetDescriptionKey: Void?
private var EmptyDataSetImageKey: Void?

public extension DYSwiftWrapper where Base: DYViewController {
    
    var emptyDataSetTitle: String {
        get { return objc_getAssociatedObject(base, &EmptyDataSetTitleKey) as? String ?? "暂无数据" }
         set { objc_setAssociatedObject(base, &EmptyDataSetTitleKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    var emptyDataSetDescription: String {
        get { return objc_getAssociatedObject(base, &EmptyDataSetDescriptionKey) as? String ?? "" }
        set { objc_setAssociatedObject(base, &EmptyDataSetDescriptionKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    var emptyDataSetImage: UIImage? {
        get { return objc_getAssociatedObject(base, &EmptyDataSetImageKey) as? UIImage ?? UIImage() }
        set { objc_setAssociatedObject(base, &EmptyDataSetImageKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}

extension DYViewController: DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    
    // MARK: - DataSource
    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        var attributes = [NSAttributedString.Key: Any]()
        attributes[NSAttributedString.Key.foregroundColor] = UIColor.custom(.assist)
        attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 16)
        return NSAttributedString(string: dy.emptyDataSetTitle, attributes: attributes)
    }
    
    public func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        var attributes = [NSAttributedString.Key: Any]()
        attributes[NSAttributedString.Key.foregroundColor] = UIColor.custom(.assist)
        attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 12)
        return NSAttributedString(string: dy.emptyDataSetDescription, attributes: attributes)
    }
    
    public func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return dy.emptyDataSetImage!
    }
    
    public func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return .clear
    }
    
    public func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 0
    }
    
    // MARK: - Delegate
    public func emptyDataSetWillAppear(_ scrollView: UIScrollView!) {
        scrollView.contentOffset = .zero
    }
    
    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}



#endif
