//
//  Test.swift
//  
//
//  Created by Yonghwi on 7/31/24.
//

import Testing
@testable import YHSwifter

struct YHFoundationExtentionsTests {

    @Test(arguments: [" hello ", "\n swifter \n"])
    func trimmedString(str: String) async throws {
        let trimmedStr = str.trimmed()
        YHDebugLog(trimmedStr)
        
        #expect(
            !trimmedStr.hasPrefix(" ") &&
            !trimmedStr.hasSuffix(" ") &&
            !trimmedStr.hasPrefix("\n") &&
            !trimmedStr.hasSuffix("\n")
        )
    }
    
    @Test(arguments: 0...4)
    func characterInString(at index: Int) async throws {
        let string = "hello"
        let secondCharacter = string.character(at: index)
        YHDebugLog(secondCharacter)
        
        switch index {
        case 0:
            #expect(secondCharacter == "h")
        case 1:
            #expect(secondCharacter == "e")
        case 2:
            #expect(secondCharacter == "l")
        case 3:
            #expect(secondCharacter == "l")
        case 4:
            #expect(secondCharacter == "o")
        default:
            break
        }
        
    }
}
