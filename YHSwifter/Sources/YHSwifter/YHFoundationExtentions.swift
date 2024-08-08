//
//  YHExtentions.swift
//
//
//  Created by Yonghwi on 7/30/24.
//

import Foundation
import UIKit

extension String {
    /// Returns a new string made by removing from both ends of
    /// the `String` characters contained `white spaces` and `New lines`
    public func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Returns string character that is the specified distance from the given index.
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
    
    /// Data to UIImage
    public func toUIImage() throws -> UIImage {
        guard let uiImage = UIImage(data: self) else {
            throw YHError(type: .failConvertedDataToUIImage, desc: "Fail to converted data to UIImage!")
        }
        
        return uiImage
    }
}

extension Dictionary {
    
    /// Dictionay to json string.
    public func toJsonString() -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else { return "" }
        guard let jsonString = String(data: data, encoding: .utf8) else { return "" }
        
        return jsonString
    }
    
    /// Convert dictionary object to url query string.
    public func toURLQuery() -> String {
        var result = ""
        for key in self.keys {
            result += "\(key)=\(self[key]!)&"
        }
        
        result.removeLast()
        
        return result
    }
}
