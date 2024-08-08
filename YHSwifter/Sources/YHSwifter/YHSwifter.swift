//
//  YHSwifter.swift
//
//
//  Created by Yonghwi on 7/30/24.
//

import Foundation
import UIKit
import Alamofire

// Enforce minimum Swift version for all platforms and build systems.
#if swift(<5.7.1)
#error("Alamofire doesn't support Swift versions below 5.7.1.")
#endif

nonisolated(unsafe) public let YH = YHSwifter.default

open class YHSwifter: NSObject {
    
    nonisolated(unsafe) public static let `default` = YHSwifter()
    
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
    
    @MainActor
    public func addImageToCache(_ image: UIImage, _ forKey: String) {
        cachedImages.setObject(image, forKey: forKey as NSString)
    }
    
    @MainActor
    public func cahcedImage(_ forKey: String) -> UIImage? {
        guard let image = cachedImages.object(forKey: forKey as NSString) else { return nil }
        
        return image
    }
    
    public func toString(_ float: CGFloat?, _ decimalCount: Int = .zero) -> String {
        if float == nil { return "0" }
        
        if decimalCount == .zero { return "\(float!)" }
        
        return String(format: "%.\(decimalCount)f", float!)
    }
    
    public func viewCount(_ count: Int) -> String {
        switch count {
        case 1_000_000_000...:
            return String(format: "%.1fB", Double(count) / 1_000_000_000).replacingOccurrences(of: ".0", with: "")
        case 1_000_000...:
            return String(format: "%.1fM", Double(count) / 1_000_000).replacingOccurrences(of: ".0", with: "")
        case 1_000...:
            return String(format: "%.1fK", Double(count) / 1_000).replacingOccurrences(of: ".0", with: "")
        default:
            return "\(count)"
        }
    }
    
    // MARK: - HTTP Client
    public func request<T: Decodable>(_ urlString: String,
                                      method: HTTPMethod = .post,
                                      parameters: [String: Any]? = nil,
                                      decoder: T.Type,
                                      headers: [String: String]? = nil) async -> YHHttpResponse<T> {
        
        var totalHeaders = HTTPHeaders.default
        totalHeaders.update(name: "Platform", value: "iOS")
        
        if headers != nil {
            for key in headers!.keys {
                totalHeaders.update(name: key, value: headers![key]!)
            }
        }

        let afRequest = AF.request(urlString,
                                   method: method,
                                   parameters: parameters,
                                   encoding: JSONEncoding.prettyPrinted,
                                   headers: totalHeaders).validate()
        
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
    
    public func requestPOST<T: Decodable>(_ urlString: String,
                                          parameters: [String: Any]? = nil,
                                          decoder: T.Type,
                                          headers: [String: String]? = nil) async -> YHHttpResponse<T> {
        return await request(urlString,
                       method: .post,
                       parameters: parameters,
                       decoder: decoder, headers: headers)
    }
    
    public func requestPUT<T: Decodable>(_ urlString: String,
                                         parameters: [String: Any]? = nil,
                                         decoder: T.Type,
                                         headers: [String: String]? = nil) async -> YHHttpResponse<T> {
        return await request(urlString,
                       method: .put,
                       parameters: parameters,
                       decoder: decoder, headers: headers)
    }
    
    public func requestPATCH<T: Decodable>(_ urlString: String,
                                           parameters: [String: Any]? = nil,
                                           decoder: T.Type,
                                           headers: [String: String]? = nil) async -> YHHttpResponse<T> {
        return await request(urlString,
                             method: .patch,
                             parameters: parameters,
                             decoder: decoder, headers: headers)
    }
    
    public func requestDELETE<T: Decodable>(_ urlString: String,
                                            parameters: [String: Any]? = nil,
                                            decoder: T.Type,
                                            headers: [String: String]? = nil) async -> YHHttpResponse<T> {
        return await request(urlString,
                             method: .delete,
                             parameters: parameters,
                             decoder: decoder, headers: headers)
    }
    
    public func requestGET<T: Decodable>(_ urlString: String,
                                         parameters: [String: Any]? = nil,
                                         decoder: T.Type,
                                         headers: [String: String]? = nil) async -> YHHttpResponse<T> {
        var defaultHeaders = HTTPHeaders.default
        
        if headers != nil {
            for key in headers!.keys {
                defaultHeaders.update(name: key, value: headers![key]!)
            }
        }        

        let afRequest = AF.request(urlString,
                                   method: .get,
                                   parameters: parameters,
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
    
    public func requestMPFD<T: Decodable>(_ urlString: String,
                                          name: String,
                                          fileName: String,
                                          fileData: Data,
                                          mimeType: String,
                                          parameters: [String: String]? = nil,
                                          decoder: T.Type,
                                          headers: [String: String]? = nil,
                                          progress: ((Int) -> Void)? = nil) async -> YHHttpResponse<T> {
        let afResponse = await AF.upload(multipartFormData: { multipartFormData in
//            _ = parameters.map({ multipartFormData.append($1, withName: $0)})
            multipartFormData.append(fileData, withName: name, fileName: fileName, mimeType: mimeType)
            
            if parameters != nil {
                _ = parameters!.map({ multipartFormData.append(Data($1.utf8), withName: $0) })
            }            
            
        }, to: urlString)
            .uploadProgress { value in
                if progress != nil {
                    progress!(Int(value.fractionCompleted * 100))
                }
            }
            .serializingDecodable(decoder).response

        var response: YHHttpResponse<T>
        
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
    
    public func downloadData(_ urlString: String) async throws -> Data {
        let afResponse = await AF.download(urlString).validate().serializingData().response
        switch afResponse.result {
        case .success(let data):
            return data
        case .failure(let afError):
            throw YHError(type: .invalidRequest, desc: afError.localizedDescription)
        }
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
