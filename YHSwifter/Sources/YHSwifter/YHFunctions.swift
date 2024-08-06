//
//  YHFunctions.swift
//
//
//  Created by Yonghwi on 7/30/24.
//

import Foundation
import UIKit


/// The language code of the language. Returns 'en' if it cannot be determined
public func YHLanguageCode() -> String {
    guard let lc = Locale.current.language.languageCode?.identifier else { return "en" }
    
    return lc
}

/// The geopolitical region identifier that identifies the time zone.
public func YHTimeZone() -> String {
    return TimeZone.current.identifier
}

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

public func YHLoadJson<T: Decodable>(_ filename: String, inAsset: Bool = true) -> T {
    let data: Data
    
    if inAsset {
        guard let assetData = NSDataAsset(name: filename)?.data else {
            fatalError("Couldn't load \(filename) from data assets!!")
        }
        
        data = assetData
        
    } else {
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            let bundleData = try Data(contentsOf: file)
            data = bundleData
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
