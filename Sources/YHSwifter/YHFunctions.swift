//
//  YHFunctions.swift
//
//
//  Created by Yonghwi on 7/30/24.
//

import Foundation

public func YHAllCookies() -> [HTTPCookie] {
    guard let allCookies = HTTPCookieStorage.shared.cookies else { return [HTTPCookie]() }
    
    return allCookies
}

public func YHAyncAfter(_ delay: TimeInterval, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
}
