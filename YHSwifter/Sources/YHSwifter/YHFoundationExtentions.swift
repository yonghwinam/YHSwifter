//
//  YHExtentions.swift
//
//
//  Created by Yonghwi on 7/30/24.
//

import Foundation
import UIKit

extension String {
    public func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public func character(at index: Int) -> String {
        guard index >= 0 && index < self.count else { return "" }
        let startIndex = self.index(self.startIndex, offsetBy: index)
        let endIndex = self.index(startIndex, offsetBy: 1)
        
        return String(self[startIndex..<endIndex])
    }
    
    public func isUnsafePassword() -> Bool {
        // 같은문자 3번 이상 연속 금지
        let passwordRegex = "^(?!.*(.)\\1\\1).*$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return !passwordTest.evaluate(with: self)
    }
}

extension Data {
    
    /// Append string to data.
    mutating public func appendString(_ string: String) {
        self.append(string.data(using: .utf8)!)
    }
    
    /// Data to json string.
    public func toJsonString() -> String {
        guard let json = try? JSONSerialization.jsonObject(with: self) else { return "" }
        let prettyJsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let jsonString = String(data: prettyJsonData, encoding: .utf8) ?? ""
        
        return jsonString
    }
}

extension Dictionary {
    
    /// Dictionay to json string.
    func toJsonString() -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else { return "" }
        guard let jsonString = String(data: data, encoding: .utf8) else { return "" }
        
        return jsonString
    }
}
