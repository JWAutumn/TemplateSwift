//
//  DYTabBarController.swift
//  BaseSwift
//
//  Created by 帝云科技 on 2019/6/5.
//  Copyright © 2019 帝云科技. All rights reserved.
//

import UIKit
import Foundation


private let tabbar_title_1 = ""
private let tabbar_title_2 = ""
private let tabbar_title_3 = ""

enum DYTabBarItem {
    case one, two, three
    
    var title: String {
        switch self {
        case .one:
            return tabbar_title_1
        case .two:
            return tabbar_title_2
        case .three:
            return tabbar_title_3
        }
    }
    
    var image: UIImage? {
        switch self {
        case .one:
            return UIImage()
        case .two:
            return UIImage()
        case .three:
            return UIImage()
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .one:
            return UIImage()
        case .two:
            return UIImage()
        case .three:
            return UIImage()
        }
    }
    
    var controller: UIViewController {
        var VC: UIViewController
        switch self {
        case .one:
            VC = DYViewController()
        case .two:
            VC = DYViewController()
        case .three:
            VC = DYViewController()
        }
        VC.title = title
        return DYNavigationController(rootViewController: VC)
    }
    
    func getController() -> UIViewController {
        let VC = controller
        let item = UITabBarItem(title: title, image: image?.withRenderingMode(.alwaysOriginal), selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        VC.tabBarItem = item
        return VC
    }
}


class DYTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dy_initialize()
        
        self.delegate = self
        let tabBarItems: [DYTabBarItem] = [.one, .two, .three]
        tabBarItems.forEach {
            addChild($0.getController())
        }
    }
    
    private func dy_initialize() -> Void {
        let tabbar: UITabBar = UITabBar.appearance()
        tabbar.isTranslucent = false
        tabbar.barTintColor = .custom(.backgroundWhite)
        
        var normalAttributes = [NSAttributedString.Key: Any]()
        normalAttributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 12)
        normalAttributes[NSAttributedString.Key.foregroundColor] = UIColor.Title
        
        var selectedAttributes = [NSAttributedString.Key: Any]()
        selectedAttributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 12)
        selectedAttributes[NSAttributedString.Key.foregroundColor] = UIColor.Base
        
        let item: UITabBarItem = UITabBarItem.appearance()
        item.setTitleTextAttributes(normalAttributes, for: .normal)
        item.setTitleTextAttributes(selectedAttributes, for: .selected)
    }
    
}

extension DYTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)
        return true
    }
}
