//
//  YHFunctions.swift
//
//
//  Created by Yonghwi on 7/30/24.
//

import Foundation
import UIKit

/// Get environment value with key.
public func YHEnvironmentValue(_ key: String) -> String {
    guard let value = ProcessInfo.processInfo.environment[key] else { return "nil" }
    return value
}

/// Get all the cookies.
public func YHAllCookies() -> [HTTPCookie] {
    guard let allCookies = HTTPCookieStorage.shared.cookies else { return [HTTPCookie]() }
    
    return allCookies
}

/// Submits a work item to a dispatch queue for asynchronous execution after a specified time.
public func YHAyncAfter(_ delay: TimeInterval, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
}
