//
//  StringExt.swift
//  BaseSwift
//
//  Created by 帝云科技 on 2020/5/27.
//  Copyright © 2020 帝云科技. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto

extension String: DYSwiftCompatibleValue {}

// MARK: - Properties
public extension DYSwiftWrapper where Base == String {
    
    
    /// base64编码
    ///
    ///     "base".dy.base64Encoded -> "5L2g5aW9"
    ///
    var base64Encoded: String? {
        return base.data(using: .utf8)?.base64EncodedString()
    }
    
    /// base64解码
    ///
    ///     "5L2g5aW9".dy.base64Decoded -> "base"
    ///
    var base64Decoded: String? {
        /// base64是4的备注，不足时用‘=’补余，
        /// 此处是防止‘=’被删除
        let remainder = base.count % 4
        var padding = ""
        if remainder > 0 {
            padding = String(repeating: "=", count: 4 - remainder)
        }
        
        guard let data = Data(base64Encoded: base + padding, options: .ignoreUnknownCharacters) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    /// url编码
    ///
    ///     "你好".dy.urlEncoded -> "%E4%BD%A0%E5%A5%BD"
    ///
    var urlEncoded: String {
        return base.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    /// url解码
    ///
    ///     "%E4%BD%A0%E5%A5%BD".dy.urlDecoded -> "你好"
    ///
    var urlDecoded: String {
        return base.removingPercentEncoding ?? base
    }
    
    /// MD5加密
    ///
    ///     "你好".dy.md5 -> "7eca689f0d3389d9dea66ae112e5cfd7"
    ///
    var md5: String {
        let utf8 = base.cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format: "%02x", $1) }
    }
    
    /// 去掉前后的换行和空格符
    ///
    ///     " 123 45 67 \n".dy.trimmed -> "123 45 67"
    ///
    var trimmed: String {
        return base.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    /// 手机号格式化
    ///
    ///     "18888888888".dy.phoneFormated -> "188****888"
    ///
    var phoneFormated: String {
        guard !base.contains("*") else { return base }
        guard base.count == 11 else { return base }
        let begin = base.index(base.startIndex, offsetBy: 3)
        let end = base.index(base.startIndex, offsetBy: 7)
        return base.replacingCharacters(in: begin...end, with: "****")
    }
    
    /// 身份证号格式化
    ///
    ///     "342222200001011234".dy.idcardFormated -> "34**************34"
    ///
    var idcardFormated: String {
        guard !base.contains("*") else { return base }
        guard base.count == 15 || base.count == 18 else { return base }
        let padding = String(repeating: "*", count: base.count - 4)
        let prefix = String(base.prefix(2))
        let suffix = String(base.suffix(2))
        return prefix + padding + suffix
    }
    
    /// 银行卡号格式化 （**** **** **** 8888）
    ///
    ///     "6225888888888888".dy.bankcardFromated -> "**** **** **** 8888"
    ///
    var bankcardFromated: String {
        guard !base.contains("*") else { return base }
        let padding = "**** **** **** "
        guard base.count > 4 else { return padding + base }
        let suffix = String(base.suffix(4))
        return padding + suffix
    }
    
    
}


// MARK: - Methods
public extension DYSwiftWrapper where Base == String {
    
    /// 拷贝到剪贴板
    func copyToPasteboard() {
        UIPasteboard.general.string = base
    }
    
    /// 时间戳转成时间格式字符串
    ///
    ///     "1590734388".dy.timestampToTime(withFormat: "yyyy-MM-dd") -> 2020-05-29
    ///
    /// - Parameter format: 格式化
    /// - Returns: 时间格式字符
    func timestampToTime(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        guard let timeInterval = Double(base) else { return base }
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    
    /// 计算字符串尺寸
    /// - Parameters:
    ///   - font: 字体大小
    ///   - size: 限制大小
    /// - Returns: 实际大小
    func sizeWithText(font: UIFont, size: CGSize) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        return (base as NSString).boundingRect(with: size, options: option, attributes: attributes, context: .none).size
    }
    
    
    // MARK: - Static func
    /// 随机字符串
    ///
    ///     String.dy.random(ofLength: 10) -> Uq9duSa9We
    ///
    /// - Parameter length: 长度
    /// - Returns: 字符串
    static func random(ofLength length: Int) -> String {
        guard length > 0 else { return "" }
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 1...length {
            randomString.append(base.randomElement()!)
        }
        return randomString
    }
    
}


// MARK: - Substring
public extension DYSwiftWrapper where Base == String {
    
    /// 截取字符串
    ///
    ///     "1234567".dy.substring(to: 4) -> 1234
    ///
    /// - Parameter to: 截取结束的位置
    /// - Returns: 截取后的字符串
    func substring(to: Int) -> String {
        let index: String.Index = base.index(base.startIndex, offsetBy: to)
        return String(base[..<index])
    }
    
    /// 截取字符串
    ///
    ///     "1234567".dy.substring(from: 3) -> 4567
    ///
    /// - Parameter to: 截取开始的位置
    /// - Returns: 截取后的字符串
    func substring(from: Int) -> String {
        let index: String.Index = base.index(base.startIndex, offsetBy: from)
        return String(base[index..<base.endIndex])
    }
    
    /// 截取字符串
    ///
    ///     "1234567".dy.substring(from: 2, to: 4) -> 34
    ///
    /// - Parameters:
    ///   - from: 开始的位置
    ///   - to: 结束的位置
    /// - Returns: 截取后的字符串
    func substring(from: Int, to: Int) -> String {
        let startIndex = base.index(base.startIndex, offsetBy: from)
        let endIndex = base.index(base.startIndex, offsetBy: to)
        return String(base[startIndex..<endIndex])
    }
}

// MARK: - Substring
public extension String {
    
    /// 字符串截取
    ///
    ///     "1234567"[3] -> 123
    ///
    subscript(to: Int) -> String {
        return dy.substring(to: to)
    }
    
    /// 字符串截取
    ///
    ///     "1234567"[3, 6] -> 456
    ///
    subscript(from: Int, to: Int) -> String {
        return dy.substring(from: from, to: to)
    }
    
    /// 安全取出字符串中的某个字符
    ///
    ///     "1234567"[safe: 5] -> 6
    ///      "1234567"[safe: 10] -> nil
    ///
    subscript(safe index: Int) -> String? {
        guard index >= 0 && index < count else { return nil }
        return String(self[self.index(startIndex, offsetBy: index)])
    }
}

// MARK: - RegEx
public extension DYSwiftWrapper where Base == String {

    enum RegEx: String {
        /// 手机号
        case mobile = "^1[3-9]\\d{9}$"
        /// 身份证号
        case idcard = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        /// 邮箱
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        /// 中文
        case chinese = "[\u{4E00}-\u{9FA5}]*$"
        /// 金额
        case money = "^\\d+(\\.\\d{1,2})?$"
        /// 纯数字
        case number = "^[0-9]+$"
        /// 验证码
        case smsCode = "^\\d{4}|\\d{6}"
        /// 银行卡
        case bankcard
    }
    
    /// 是否是手机号
    var isMobile: Bool {
        return isMatch(regex: .mobile)
    }
    
    /// 是否是身份证号
    var isIdcard: Bool {
        return isMatch(regex: .idcard)
    }
    
    /// 是否是邮箱
    var isEmail: Bool {
        return isMatch(regex: .email)
    }
    
    /// 是否是中文
    var isChinese: Bool {
        return isMatch(regex: .chinese)
    }
    
    /// 是否是金额
    var isMoney: Bool {
        return isMatch(regex: .money)
    }
    
    /// 是否是数字
    var isNumber: Bool {
        return isMatch(regex: .number)
    }
    
    /// 是否是验证码
    var isSMSCode: Bool {
        return isMatch(regex: .smsCode)
    }
    
    /// 是否是银行卡号
    var isBankcard: Bool {
        guard !base.isEmpty else { return false }
        
        var sumOdd = 0
        var sumEven = 0
        let length = base.count
        let last = Int(String(base.last!))!
        let number = String(base.prefix(base.count - 1))
        
        for (idx, char) in number.reversed().enumerated() {
            var temp = Int(String(char))!
            if length % 2 == 1 {
                guard idx % 2 == 0 else {
                    sumOdd += temp
                    continue
                }
                temp *= 2
                if temp >= 10 {
                    temp -= 9
                }
                sumEven += temp
            } else {
                guard idx % 2 == 1 else {
                    sumOdd += temp
                    continue
                }
                temp *= 2
                if temp >= 10 {
                    temp -= 9
                }
                sumEven += temp
            }
        }
       let sum = sumOdd + sumEven + last
        return sum % 10 == 0
    }
    
    
    /// 正则表达式匹配 - 枚举方式
    /// - Parameter regex: 枚举类型
    /// - Returns: true or false
    func isMatch(regex: RegEx) -> Bool {
        guard regex != .bankcard else { return isBankcard }
        return isMatch(regex.rawValue)
    }
    
    
    /// 正则表达式匹配
    /// - Parameter rules: 匹配规则
    /// - Returns: true or false
    private func isMatch(_ rules: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", rules)
        return predicate.evaluate(with: base)
    }
}
