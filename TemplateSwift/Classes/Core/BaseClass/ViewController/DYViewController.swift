//
//  DYViewController.swift
//  BaseSwift
//
//  Created by 帝云科技 on 2019/6/5.
//  Copyright © 2019 帝云科技. All rights reserved.
//

import UIKit

public class DYViewController: UIViewController {
    
    public var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    public var isStatusBarHidden: Bool = false {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
    deinit {
        debugPrint(#function + ": " + String(describing: type(of: self)))
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        dy_setupData()
        dy_setupUI()
        dy_requestData()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.defaultNavigationBar()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        dy_reloadData()
    }
    
    public func dy_setupData() -> Void {
        dy.emptyDataSetTitle = ""
    }
    
    public func dy_setupUI() -> Void {
        navigationItem.backBarButtonItem = backBarButton
        view.backgroundColor = .custom(.section)
    }
    
    public func dy_requestData() -> Void {}
    
    public func dy_reloadData() {}
}



public extension DYViewController {
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
}


