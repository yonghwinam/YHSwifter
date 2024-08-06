//
//  YHLogger.swift
//
//
//  Created by Yonghwi on 7/30/24.sdfsdf
//

import Foundation


// MARK: - Debug Log
public func YHDebugLog(_ message: Any?, functionName: StaticString = #function, fileName: NSString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
    let className = fileName.lastPathComponent
#if DEBUG
    if message != nil {
        print(" 🧐 \(className):\(lineNumber) - \(functionName)> \(message!)")
    } else {
        print(" 🧐 \(className):\(lineNumber) >")
    }
#endif
}

public func YHInfoLog(_ message: Any?, functionName: StaticString = #function, fileName: NSString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
    let className = fileName.lastPathComponent
#if DEBUG
    if message != nil {
        print(" ℹ️ \(className):\(lineNumber) - \(functionName)> \(message!)")
    } else {
        print(" ℹ️ \(className) \(lineNumber)>")
    }
#endif
}

public func YHWarningLog(_ message: Any?, functionName: StaticString = #function, fileName: NSString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
    let className = fileName.lastPathComponent
#if DEBUG
    if message != nil {
        print(" ⚠️ \(className):\(lineNumber) - \(functionName)> \(message!)")
    } else {
        print(" ⚠️ \(className):\(lineNumber)>")
    }
#endif
}

public func YHErrorLog(_ message: Any?, functionName: StaticString = #function, fileName: NSString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
    let className = fileName.lastPathComponent
#if DEBUG
    if message != nil {
        print(" ❌ \(className):\(lineNumber) - \(functionName)> \(message!)")
    } else {
        print(" ❌ \(className):\(lineNumber)>")
    }
#endif
}

public func YHResponseLog<T: Decodable>(_ response: YHHttpResponse<T>?,
                                        _ printResult: Bool = true,
                                        functionName: StaticString = #function,
                                        fileName: NSString = #file,
                                        lineNumber: Int = #line) {
    let className = fileName.lastPathComponent
#if DEBUG
    if response != nil {
        let method = response?.request?.httpMethod ?? YHMessageUnknown
        let url = response?.request?.url?.absoluteString ?? YHMessageUnknown
        let headers = response?.request?.allHTTPHeaderFields?.toJsonString() ?? YHMessageNone
        let statusCode = response?.statusCode ?? YHError.unknown
        let body = response?.request?.httpBody?.toJsonString() ?? YHMessageNone
        
        if response!.error != nil {
            let errorMessage = response!.error!.desc
            print(" 🛜 \(className):\(lineNumber) - \(functionName)> \(method) \(url)\nHeaders: \(headers)\nBody: \(body)\nError: \(errorMessage)")
            
        } else {
            var result = YHMessageNone
            if printResult {
                result = response?.result?.toJsonString() ?? YHMessageNone
            } else {
                result = YHMessageDisablePrintResult
            }
            print(" 🛜 \(className):\(lineNumber) - \(functionName)> \(method) \(url)\nHeaders: \(headers)\nBody: \(body)\nStatus Code: \(statusCode)\nResult: \(result)")
        }
    }
#endif
}
