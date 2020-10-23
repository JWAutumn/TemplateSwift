//
//  DYNavigationController.swift
//  BaseSwift
//
//  Created by 帝云科技 on 2019/6/5.
//  Copyright © 2019 帝云科技. All rights reserved.
//

import UIKit

class DYNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
    
//    var panDelegate: UIGestureRecognizerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dy_initialize()
        
        self.delegate = self
    }
    
    private func dy_initialize() {
        
        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] = UIFont.systemFont(ofSize: 17)
        attributes[.foregroundColor] = UIColor.Title
        
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = .custom(.backgroundWhite)
        navigationBar.tintColor = .Title
        navigationBar.titleTextAttributes = attributes
        #warning("custom back image")
        navigationBar.backIndicatorImage = UIImage()
        navigationBar.backIndicatorTransitionMaskImage = UIImage()
        
        interactivePopGestureRecognizer?.isEnabled = false
    }
   
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
}


extension UINavigationController {
    func clearNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.backgroundColor = .clear
        navigationBar.isTranslucent = true
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func defaultNavigationBar() {
        navigationBar.setBackgroundImage(nil, for: .default)
        navigationBar.backgroundColor = .custom(.backgroundWhite)
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Title]
    }
}
