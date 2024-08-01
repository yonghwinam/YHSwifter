//
//  Test.swift
//  
//
//  Created by Yonghwi on 7/31/24.
//

import Testing
import Foundation
@testable import YHSwifter

struct YHFunctionsTests {
    @Test func environmentValue() async throws {
        let envValue = YHEnvironmentValue("ENV_KEY")
        YHDebugLog("env value: \(envValue)")
        
        #expect(envValue == "env value")
    }
}
