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
public func YHAyncAfter(_ delay: TimeInterval, closure: @Sendable @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
}

public func YHLoadJsonFile<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
