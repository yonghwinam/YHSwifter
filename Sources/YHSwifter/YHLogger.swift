//
//  YHLogger.swift
//
//
//  Created by Yonghwi on 7/30/24.
//

import Foundation

let LOG_REQUEST       =       true
let LOG_RESPONSE      =       false
let LOG_PUSH_ID       =       false

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
