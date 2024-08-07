//
//  File.swift
//  YHSwifter
//
//  Created by Yonghwi on 8/1/24.
//

import Foundation
import UIKit

public let YHMessageUnknown = "Unknown"
public let YHMessageNone = "None"
public let YHMessageDisablePrintResult = "(Disable print result log.)"

@frozen
public enum YHHttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case options = "OPTIONS"
}

@frozen
public enum YHHttpContentType: String {
    case json = "application/json"
    case multipart = "multipart/form-data"
}

public struct YHHttpResponse<T: Decodable> {
    public let statusCode: Int
    public let result: Data?
    public let decodedResult: T?
    public let request: URLRequest?
    public let response: HTTPURLResponse?
    public let error: YHError?
}

public struct YHError: Error {
    public enum type: Sendable{
        case objectIsNil(String)
        case invalidRequest
        case invalidURLString
        case invalidJsonData
        case failToMakeHTTPCookie
        case missingRequiredHTTPCookiePropertie(String)
    }
    
    public let type: type
    public let desc: String
    public static let unknown = -99999
    
    public init(type: type, desc: String) {
        self.type = type
        self.desc = desc
    }
}

