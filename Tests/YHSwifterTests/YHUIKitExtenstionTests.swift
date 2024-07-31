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

    @Test(arguments: ["img1.jpg", "img2.jpg", "img3.jpg"])
    func UIImage_resize(imgName: String) async throws {
        let otherSize = CGSize(width: 640, height: 480)
        
        let uiImage = UIImage(named: imgName, in: Bundle.module, compatibleWith: nil)
        YHDebugLog("origin size: \(uiImage!.size)")
        
        let resizedImage = uiImage?.resized(to: otherSize)
        YHDebugLog("resized image size: \(resizedImage!.size)")
        
        #expect(resizedImage?.size == otherSize)
    }
}
