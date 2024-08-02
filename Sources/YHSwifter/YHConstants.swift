//
//  File.swift
//  YHSwifter
//
//  Created by Yonghwi on 8/1/24.
//

import Foundation
import UIKit

struct YHError: Error {
    enum type  {
        case failToMakeHTTPCookie
        case missingRequiredHTTPCookiePropertie(String)
    }
    
    let type: type
    let desc: String
}

