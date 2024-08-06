//
//  DemoTests.swift
//  DemoTests
//
//  Created by Yonghwi on 8/2/24.
//

import Testing
import Foundation
import YHSwifter

@testable import Demo

struct DemoTests {
    
    let swifter = YHSwifter(standardSize: CGSize(width: 100, height: 100))

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    
    @Test(arguments: ["https://httpbin.org/get", "error https://httpbin.org/get"])
    func requestGET(urlString: String) async throws {
        let response = await swifter.requestGET(urlString,
                                                YHDummyModel.self,
                                                headers: ["key1": "value1", "key2": "value2"])
        let statusCode = response.statusCode
        YHDebugLog("status code: \(statusCode)")
        if urlString == "https://httpbin.org/get" {
            #expect(statusCode == 200)
        } else {
            #expect(statusCode == YHError.unknown)
        }
        
        YHResponseLog(response)
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
}
