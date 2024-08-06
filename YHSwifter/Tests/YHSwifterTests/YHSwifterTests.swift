import Testing
import Foundation
@testable import YHSwifter

struct YHSwifterTests {
    let swifter = YHSwifter(standardSize: CGSize(width: 100, height: 100))
    
    @Test func logger() {
        YHDebugLog("This debug log.")
        YHInfoLog("This is info log.")
        YHWarningLog("This is warning log.")
        YHErrorLog("This is error log.")
    }

    @Test func bundleInfo() {
        let appVersion = swifter.appVersion()
        YHDebugLog("appVersion: \(appVersion)")
        
        let buildVersion = swifter.buildVersion()
        YHDebugLog("buildVersion: \(buildVersion)")
        
        let marketingVersion = swifter.marketVersion()
        YHDebugLog("marketingVersion: \(marketingVersion)")
    }
    
    @Test func environimentValue() async throws {
        let envValue = swifter.environmentValue("ENV_KEY")
        YHDebugLog("ENV Value: \(envValue)")
        #expect(envValue == "Hello Swifter")
    }
    
    @Test func asynAfter() {
        swifter.asyncAfter(3.0) {
            YHDebugLog("This message printing after 3s.")
        }
    }
    
    @Test func httpCookieHanlder() async throws {
        do {
            let cookie = try swifter.makeCookie([
                .domain: "https://www.example.com",
                .originURL: "https://www.example.com",
                .name: "sample cookie",
                .value: "123131321",
                .path: "/"
            ])
            
            swifter.addCookie(cookie)
            
        } catch let e as YHError {
            YHErrorLog(e.desc)
            YHErrorLog(e.type)
        }
        
        var allCookies = swifter.allCookies()
        YHDebugLog("all cookies after add cookie: \(allCookies)")
        #expect(allCookies.count == 1)
        
        swifter.deleteCookie(by: "sample cookie")
        //        swifter.deleteAllCookies()
        allCookies = swifter.allCookies()
        YHDebugLog("all cookies after delete cookie: \(allCookies)")
        
        #expect(allCookies.count == 0)
        
    }
    
    @Test func layout() async throws {
        let statusBarHeight = await swifter.statusBarHeight()
        YHDebugLog("status bar height:  \(statusBarHeight)")
    }
}
