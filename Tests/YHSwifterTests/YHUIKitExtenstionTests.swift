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
    
    @Test(arguments: [40, 278])
    func UIImage_resizeBy(width: CGFloat) async throws {
        let uiImage = UIImage(named: "img1.jpg", in: Bundle.module, compatibleWith: nil)
        YHDebugLog("image size: \(uiImage!.size)")
        let imageRatio = String(format: "%.3f", uiImage!.size.height / uiImage!.size.width)
        YHDebugLog("image ratio: \(imageRatio)")
        
        let resizedImage = uiImage?.resizedBy(width: width)
        YHDebugLog("resize image size: \(resizedImage!.size)")
        let resizedRatio = String(format: "%.3f", resizedImage!.size.height / resizedImage!.size.width)
        YHDebugLog("resized image ratio: \(resizedRatio)")
    }
    
    @Test(arguments: [26, 176])
    func UIImage_resizeBy(height: CGFloat) async throws {
        let uiImage = UIImage(named: "img1.jpg", in: Bundle.module, compatibleWith: nil)
        YHDebugLog("image size: \(uiImage!.size)")
        let imageRatio = String(format: "%.3f", uiImage!.size.height / uiImage!.size.width)
        YHDebugLog("image ratio: \(imageRatio)")
        
        let resizedImage = uiImage?.resizedBy(height: height)
        YHDebugLog("resize image size: \(resizedImage!.size)")
        let resizedRatio = String(format: "%.3f", resizedImage!.size.height / resizedImage!.size.width)
        YHDebugLog("resized image ratio: \(resizedRatio)")
    }
}
