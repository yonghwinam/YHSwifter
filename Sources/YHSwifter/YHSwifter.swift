//
//  YHSwifter.swift
//
//
//  Created by Yonghwi on 7/30/24.
//

import Foundation
import UIKit

open class YHSwifter: NSObject {
    
    // MARK: - Global Variables.
    private var standardSize: CGSize
    @MainActor private var screenSize: CGSize { get { return UIScreen.main.bounds.size } }
    
    
    // MARK: - Initializer
    init(standardSize: CGSize = CGSize(width: 393.0, height: 852.0)) {
        self.standardSize = standardSize
    }
    
    // MARK: - Common Methods
    /// Get build version info.
    public func buildVersion() -> Int {
        let mainBundle = Bundle.main
        let buildVersionString = mainBundle.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        guard let buildVersion = Int(buildVersionString) else { return 0 }
        
        return buildVersion
    }
    
    /// Get app version info.
    public func appVersion() -> String {
        guard
            let infoDic = Bundle.main.infoDictionary as [String: Any]?,
            let marketVersion = infoDic["CFBundleShortVersionString"] as? String else { return "Error"}
        
        return marketVersion
    }
    
    /// The variable names (keys) and their values in the environment from which the process was launched.
    public func environmentValue(_ key: String) -> String {
        guard let value = ProcessInfo.processInfo.environment[key] else { return "" }
        
        return value
    }
    
    /// Marketing Version (ex. 1.0.1(1001))
    public func marketVersion() -> String {
        return "\(appVersion())(\(buildVersion()))"
    }
    
    /// Get language code. Default 'en'
    public func LanguageCode() -> String {
        guard let lc = Locale.current.language.languageCode?.identifier else { return "en" }
        
        return lc
    }
    
    /// Get all cookies.
    public func allCookies() -> [HTTPCookie] {
        guard let allCookies = HTTPCookieStorage.shared.cookies else { return [HTTPCookie]() }
        
        return allCookies
    }
    
    public func deleteAllCookies() {
        for cookie in allCookies() {
            HTTPCookieStorage.shared.deleteCookie(cookie)
        }
    }
    
    /// Creates an HTTP cookie instance with the given cookie properties and set to HTTPCookieStorage
    /// Required properties: name, value, domain or originURL
    public func makeCookie(_ properties: [HTTPCookiePropertyKey: Any]) throws -> HTTPCookie {
        
        guard let cookie = HTTPCookie(properties: properties) else {
            var validKeys = [String]()
            
            for key in properties.keys {
                validKeys.append(key.rawValue)
            }
            
            YHDebugLog(validKeys)
            
            if !validKeys.contains("Name") {
                throw YHError(
                    type: .missingRequiredHTTPCookiePropertie("HTTPCookiePropertyKey.name"),
                    desc: "Required 'HTTPCookiePropertyKey.name' propertie."
                )
            }
            
            if !validKeys.contains("Value") {
                throw YHError(
                    type: .missingRequiredHTTPCookiePropertie("HTTPCookiePropertyKey.value"),
                    desc: "Required 'HTTPCookiePropertyKey.value' propertie."
                )
            }
            
            if !validKeys.contains("Path") {
                throw YHError(
                    type: .missingRequiredHTTPCookiePropertie("HTTPCookiePropertyKey.path"),
                    desc: "Required 'HTTPCookiePropertyKey.path' propertie."
                )
            }
            
            if !validKeys.contains("OriginURL") {
                throw YHError(
                    type: .missingRequiredHTTPCookiePropertie("HTTPCookiePropertyKey.originURL"),
                    desc: "Required 'HTTPCookiePropertyKey.originURL' propertie."
                )
            }
            
            throw YHError(type: .failToMakeHTTPCookie, desc: "Fail to make HTTPCookie.")
        }
        
        return cookie
    }
    
    /// Set cookie to shared HTTPCookieStorage.
    public func addCookie(_ cookie: HTTPCookie) {
        HTTPCookieStorage.shared.setCookie(cookie)
    }
    
    /// Deletes the specified name cookie  from the cookie storage.
    public func deleteCookie(by name: String) {
        let allCookies = allCookies()
        
        for cookie in allCookies {
            if name == cookie.name {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
    }
    
    public func asyncAfter(_ delay: TimeInterval, execute: @Sendable @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: execute)
    }
    
    // MARK: - Layout Methods
    @MainActor
    public func wratio(_ value: CGFloat) -> CGFloat {
        let ratio = standardSize.width / screenSize.width

        return (value * ratio)
    }
    
    @MainActor
    public func hratio(_ value: CGFloat) -> CGFloat {
        let ratio = standardSize.height / screenSize.height
        
        return (value * ratio)
    }
}
