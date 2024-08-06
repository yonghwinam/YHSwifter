//
//  File.swift
//  YHSwifter
//
//  Created by Yonghwi on 8/5/24.
//

import Foundation

class YHHttpClient: NSObject {
    
    var timeoutInterval:TimeInterval
    
    init(timeoutInterval: TimeInterval = 30) {
        self.timeoutInterval = timeoutInterval
        
    }
    
    func request(_ urlString: String,
                 method: YHHttpMethod = .post,
                 contentType: YHHttpContentType = .json,
                 parameters: [String: Any],
                 headers: [String: Any]? = nil) async throws -> (Data, HTTPURLResponse)  {
        
        guard let url = URL(string: urlString) else {
            throw YHError(type: .invalidURLString, desc: "")
        }
        
        var request = URLRequest(url: url, timeoutInterval: timeoutInterval)
        request.httpMethod = method.rawValue
        request.addValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        request.addValue(YHLanguageCode(), forHTTPHeaderField: "Accept-Language")
        request.addValue(YHTimeZone(), forHTTPHeaderField: "TimeZone")
        request.addValue("ios", forHTTPHeaderField: "Platform")
        
        
        return (Data(), HTTPURLResponse())
        
    }
}
