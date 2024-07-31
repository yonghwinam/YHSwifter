//
//  Test.swift
//  
//
//  Created by Yonghwi on 7/31/24.
//

import Testing
import Foundation
import UIKit
@testable import YHSwifter

struct YHUIKitExtenstionTests {

    @Test func UIImage_resize() async throws {
        let otherSize = CGSize(width: 640, height: 480)
        
        let uiImage = UIImage(named: "img1.jpg", in: Bundle.module, compatibleWith: nil)
        YHDebugLog(uiImage?.size)
        
        let resizedImage = uiImage?.resized(to: otherSize)
        YHDebugLog(resizedImage?.size)
        
        #expect(resizedImage?.size == otherSize)
    }

}
