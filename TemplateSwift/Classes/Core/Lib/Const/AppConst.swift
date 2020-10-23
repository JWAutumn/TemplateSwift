//
//  AppConst.swift
//  BaseSwift
//
//  Created by 帝云科技 on 2020/5/20.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import Foundation
import UIKit


public let ScreenSize: CGSize = UIScreen.main.bounds.size

public let ScreenWidth: CGFloat = ScreenSize.width

public let ScreenHeight: CGFloat = ScreenSize.height

public let NavigationBarHeight: CGFloat = 44

public let StatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height

public let NavigationStatusHeight: CGFloat = (NavigationBarHeight + StatusBarHeight)

public let HomeIndicatorHeight: CGFloat = isIPhoneX ? 34 : 0

public let TabBarHeight: CGFloat = (49 + HomeIndicatorHeight)


public var isIPhoneX: Bool {
    guard UIDevice.current.userInterfaceIdiom == .phone else { return false }
    guard #available(iOS 11.0, *) else { return false }
    guard let window = UIApplication.shared.delegate?.window else { return false }
    return window!.safeAreaInsets.bottom > 0
}

public var isIPhone5SE: Bool {
    guard UIDevice.current.userInterfaceIdiom == .phone else { return false }
    return (ScreenWidth == 320 && ScreenHeight == 568)
}


public struct App {
    
    public static let infoDictionary = Bundle.main.infoDictionary
    
    public static let bundleId: String = Bundle.main.bundleIdentifier!
    
    public static let name: String = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    
    public static let version: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    
    public static let bulidVersion: String = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
}

public struct Device {
    
    public static let name: String = UIDevice.current.systemName
    
    public static let version: String = UIDevice.current.systemVersion
}


