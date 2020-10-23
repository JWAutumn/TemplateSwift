//
//  AppConfig.swift
//  TemplateSwift
//
//  Created by 帝云科技 on 2020/10/23.
//

import UIKit
import IQKeyboardManagerSwift


final class AppConfig {
    static let shared = AppConfig()
    
    var window: UIWindow?
    
    
    private init() {
        
    }
    
    public func showInitialController(in window: UIWindow?) {
        guard window != nil else { return }
        self.window = window
        
    }
    
    public func config() {
        configKeyboard()
    }
    
    private func configKeyboard() {
        let shared = IQKeyboardManager.shared
        shared.enable = true
        shared.shouldResignOnTouchOutside = true
        shared.shouldShowToolbarPlaceholder = false
    }
}

