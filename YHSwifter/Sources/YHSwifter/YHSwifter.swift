//
//  YHSwifter.swift
//
//
//  Created by Yonghwi on 7/30/24.
//

import Foundation
import UIKit
import Alamofire

open class YHSwifter: NSObject {
    
    // MARK: - Global Variables.
    private var standardSize: CGSize
    @MainActor private var screenSize: CGSize { get { return UIScreen.main.bounds.size } }
    
    
    // MARK: - Initializer
    public init(standardSize: CGSize = CGSize(width: 393.0, height: 852.0)) {
        
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
    public func languageCode() -> String {
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
    
    // MARK: - HTTP Client
    public func requestGET<T: Decodable>(_ urlString: String,
                                         _ decoder: T.Type,
                                         headers: [String: String]? = nil) async -> YHHttpResponse<T> {
        var defaultHeaders = HTTPHeaders.default
        
        if headers != nil {
            for key in headers!.keys {
                defaultHeaders.update(name: key, value: headers![key]!)
            }
        }        

        let afRequest = AF.request(urlString, method: .get,
                                 headers: defaultHeaders).validate()
        
        var response: YHHttpResponse<T>
        
        let afResponse = await afRequest.serializingDecodable(decoder).response
            
        switch afResponse.result {
        case .success(let decodedResult):
            response = YHHttpResponse(statusCode: afResponse.response?.statusCode ?? YHError.unknown,
                                      result: afResponse.data,
                                      decodedResult: decodedResult,
                                      request: afResponse.request,
                                      response: afResponse.response,
                                      error: nil)
        case .failure(let error):
            response = YHHttpResponse(statusCode: afResponse.response?.statusCode ?? YHError.unknown,
                                      result: nil,
                                      decodedResult: nil,
                                      request: afResponse.request,
                                      response: afResponse.response,
                                      error: YHError(type: .invalidRequest, desc: error.localizedDescription))
        }
        
        return response
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
    
    
    @MainActor
    /// Height of the status bar.
    public func statusBarHeight() -> CGFloat {
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        guard let height = windowScenes?.statusBarManager?.statusBarFrame.height as? CGFloat else {
            return 44.0
        }
        
        return height
    }
}
