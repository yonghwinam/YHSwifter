//
//  DemoTests.swift
//  DemoTests
//
//  Created by Yonghwi on 8/2/24.
//

import Testing
import Foundation
import UIKit
import YHSwifter

@testable import Demo

struct DemoTests {
    
    let swifter = YHSwifter(standardSize: CGSize(width: 100, height: 100))

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    
    @Test(arguments: ["https://dummyjson.com/users/search"])
    func requestGET(urlString: String) async throws {
        let response = await swifter.requestGET(urlString,
                                                parameters: ["q": "John"],
                                                decoder: YHUser.self,
                                                headers: ["key1": "value1", "key2": "value2"])
        YHResponseLog(response)
        let statusCode = response.statusCode
        #expect(statusCode == 200)
    }
    
    @Test(arguments: ["https://dummyjson.com/user/login"])
    func requestPOST(urlString: String) async throws {
        let parameters = ["username": "emilys", "password": "emilyspass", "expiresInMins": 30] as [String: Any]
        
        let response = await swifter.requestPOST(urlString, parameters: parameters, decoder: YHUser.self)
        YHResponseLog(response)
        #expect(response.statusCode == 200)
    }
    
    @Test(arguments: ["https://dummyjson.com/users/2"])
    func requestPUT(urlString: String) async throws {
        let parameters = ["lastName": "hello"] as [String: Any]
        
        let response = await swifter.requestPATCH(urlString, parameters: parameters, decoder: YHUser.self)
        YHResponseLog(response)
        #expect(response.statusCode == 200)
        
        let user = response.decodedResult
        #expect(user != nil)
        YHDebugLog("last name: \(user!.lastName!)")
    }
    
    @Test(arguments: ["https://dummyjson.com/users/1"])
    func requestDELETE(urlString: String) async throws {        
        let response = await swifter.requestDELETE(urlString, parameters: nil, decoder: YHUser.self)
        YHResponseLog(response)
        #expect(response.statusCode == 200)
        
        let user = response.decodedResult
        #expect(user?.isDeleted == true)
        YHDebugLog("last name: \(user!.lastName!)")
    }
    
    @Test(arguments: ["https://httpbin.org/post"])
    func requestMPFD(urlString: String) async throws {
        let fileName = "img2.jpg"
        let image = UIImage(named: fileName)
        YHDebugLog(image!.pngData()!.count)
        
        let response = await swifter.requestMPFD(urlString,
                                                 name: "file",
                                                 fileName: fileName,
                                                 fileData: image!.jpegData(compressionQuality: 0.5)!,
                                                 mimeType: "image/jpeg",
                                                 parameters: nil,
                                                 decoder: YHCartoonizerModel.self) { progress in
            YHDebugLog("progress: \(progress)")
        }
            
        YHResponseLog(response, false)
    }
    
    @Test func requestCartoonizer() async throws {
        let urlString = "https://nutm4narnj.execute-api.us-east-1.amazonaws.com/Prod/cartoonizer"
        guard let imageData = UIImage(named: "fhd.jpg")?.jpegData(compressionQuality: 0.7) else { return }
        
        let response = await swifter.requestMPFD(urlString,
                                                 name: "file",
                                                 fileName: "fhd.jpg",
                                                 fileData: imageData,
                                                 mimeType: "image/jpeg",
                                                 parameters: ["style": "s001"],
                                                 decoder: YHCartoonizerModel.self) { progress in
            YHDebugLog("progress: \(progress)")
        }
        
        YHResponseLog(response)
        guard let cartoonizer = response.decodedResult else { return }
        YHDebugLog("artwork url: \(cartoonizer.artworkUrl ?? YHMessageUnknown)")
    }
    
    @Test func dictionaryToURLQuery() async throws {
        let dic = ["key1": "value1", "key2": "value2", "key3": "value3"]
        let result = dic.toURLQuery()
        YHDebugLog("result: \(result)")
    }
}
