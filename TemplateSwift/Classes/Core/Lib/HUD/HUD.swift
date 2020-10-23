//
//  HUD.swift
//  BaseSwift
//
//  Created by 帝云科技 on 2020/5/25.
//  Copyright © 2020 帝云科技. All rights reserved.
//

#if canImport(MBProgressHUD)
import MBProgressHUD


/// 不透明时背景色
fileprivate var HUDBackgroundColor: UIColor {
    if #available(iOS 13.0, *) {
        return UIColor(dynamicProvider: { return $0.userInterfaceStyle == .dark ? .black : .white })
    } else {
        return .white
    }
}

/// 加载框背景色
fileprivate var HUDBezelViewBackgroundColor: UIColor {
    if #available(iOS 13.0, *) {
        return UIColor(dynamicProvider: { return $0.userInterfaceStyle == .dark ? UIColor(white: 0.3, alpha: 1) : .black })
    } else {
    return .black
    }
}

/// 内容颜色
fileprivate let HUDContentColor: UIColor = .white

/// 文本提示框隐藏时间
public let HUDTextAfterDelayTime: TimeInterval = 1.2

public struct HUD {
    
    @discardableResult
    public static func show(_ view: UIView?, text: String?, opaque: Bool = false, offset: CGPoint = .zero, image: UIImage? = nil, mode: MBProgressHUDMode = .indeterminate) -> MBProgressHUD {
        
        var superView: UIView!
        if view == nil {
            superView = UIViewController.dy.currentController()?.view
        } else {
            superView = view!
        }
        
        let hud: MBProgressHUD = MBProgressHUD.forView(superView) ?? MBProgressHUD.showAdded(to: superView, animated: true)
        hud.offset = offset
        hud.label.text = text
        hud.mode = mode
        if mode == .customView, image != nil {
            hud.customView = UIImageView(image: image!)
        }
        
        if opaque {
            hud.backgroundColor = HUDBackgroundColor
        }
        
        hud.margin = 13
        hud.bezelView.color = HUDBezelViewBackgroundColor
        hud.bezelView.style = .solidColor
        hud.label.font = .systemFont(ofSize: 15)
        hud.contentColor = HUDContentColor
        hud.animationType = .fade
        hud.removeFromSuperViewOnHide = true
        hud.bezelView.transform = .init(scaleX: 0.9, y: 0.9)
        
        return hud
    }
    
    
    public static func hide(_ view: UIView? = nil) {
        var superView: UIView!
        if view == nil {
            superView = UIViewController.dy.currentController()?.view
        } else {
            superView = view!
        }
        MBProgressHUD.hide(for: superView, animated: true)
    }
    
    
    /// 隐藏HUD 针对网络请求的操作处理
    /// 判断如果view上的hud是加载状态则隐藏，否则不作处理
    /// - Parameter view: 显示的view
    public static func hideIndeterminate(_ view: UIView?) {
        guard
            let view = view,
            let hud = MBProgressHUD.forView(view),
            hud.mode == .indeterminate
        else { return }
        hide(view)
    }
}


public extension HUD {
    
    private enum HUDImageState {
        case success, error, info
        
        var imageName: String {
            let bundle = "HUDBundle.bundle/"
            switch self {
            case .success: return bundle + "HUD_success"
            case .error: return bundle + "HUD_error"
            case .info: return bundle + "HUD_info"
            }
        }
    }
    
    static func show(text: String?) {
        show(text: text, image: nil)
    }
    
    static func showSuccess(text: String?) {
        show(text: text, state: .success)
    }
    
    static func showError(text: String?) {
        show(text: text, state: .error)
    }
    
    static func showInfo(text: String) {
        show(text: text, state: .info)
    }
    
    static func show(text: String?, imageName: String) {
        let image = UIImage(named: imageName)
        show(text: text, image: image)
    }
    
    static func show(text: String?, image: UIImage?, delay: TimeInterval = HUDTextAfterDelayTime) {
        guard text != nil else { return }
        guard !text!.isEmpty else { return }
        
        var mode: MBProgressHUDMode
        if image != nil {
            mode = .customView
        } else {
            mode = .text
        }
        let hud = show(nil, text: text, image: image, mode: mode)
        hud.hide(animated: true, afterDelay: delay)
    }
    
    private static func show(text: String?, state: HUDImageState) {
        show(text: text, image: UIImage(named: state.imageName))
    }
}

public extension HUD {
    
    static func show(view: UIView? = nil) {
        show(view: view, text: nil)
    }
    
    static func show(view: UIView?, text: String?, opaque: Bool = false, offset: CGPoint = .zero) {
        show(view, text: text, opaque: opaque, offset: offset)
    }
    
}


public extension DYSwiftWrapper where Base: UIView {
    
    func showTextHUD(_ text: String?) {
        HUD.show(text: text)
    }
    
    func showSuccessHUD(text: String?) {
        HUD.showSuccess(text: text)
    }
    
    func showErrorHUD(text: String) {
        HUD.showError(text: text)
    }
    
    func showInfoHUD(text: String) {
        HUD.showInfo(text: text)
    }
    
    
    func showHUD(opaque: Bool = false) {
        HUD.show(view: base, text: nil, opaque: opaque)
    }
    
    func hideHUD() {
        HUD.hide(base)
    }
    
}


public extension DYSwiftWrapper where Base: UIViewController {
    
    func showTextHUD(_ text: String?) {
        base.view.dy.showTextHUD(text)
    }
    
    func showSuccessHUD(text: String?) {
        base.view.dy.showSuccessHUD(text: text)
    }
    
    func showErrorHUD(text: String) {
        base.view.dy.showErrorHUD(text: text)
    }
    
    func showInfoHUD(text: String) {
        base.view.dy.showInfoHUD(text: text)
    }
    
    func showHUD(opaque: Bool = false) {
        base.view.dy.showHUD(opaque: opaque)
    }
    
    func hideHUD() {
        base.view.dy.hideHUD()
    }
}


#endif
