//
//  YHSwifter.swift
//
//
//  Created by Yonghwi on 7/30/24.
//

import Foundation

open class YHSwifter: NSObject {
    
    // App version
    public var appVersion: String {
        get {
            guard
                let infoDic = Bundle.main.infoDictionary as [String: Any]?,
                let marketVersion = infoDic["CFBundleShortVersionString"] as? String else { return "Error"}
            
            return marketVersion
        }
    }
    
    // Build version
    public var buildVersion: Int {
        get {
            let mainBundle = Bundle.main
            let buildVersionString = mainBundle.object(forInfoDictionaryKey: "CFBundleVersion") as! String
            guard let buildVersion = Int(buildVersionString) else { return 0 }
            
            return buildVersion
        }
    }
    
    // Language code
    public var LanguageCode: String {
        get {
            guard let lc = Locale.current.language.languageCode?.identifier else { return "en" }
            
            return lc
        }
    }
    
    // Marketing Version (ex. 1.0.1(1001))
    public func marketVersion() -> String {
        
        return "\(appVersion)(\(buildVersion))"
    }
    
    // All cookies.
    public func allCookies() -> [HTTPCookie] {
        guard let allCookies = HTTPCookieStorage.shared.cookies else { return [HTTPCookie]() }
        
        return allCookies
    }
}
