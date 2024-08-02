import Testing
@testable import YHSwifter

struct YHSwifterTests {
    let swifter = YHSwifter()
    
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
    
    @Test func makeCookie() async throws {
        do {
            let cookie = try swifter.makeCookie([
                .domain: "https://www.example.com",
                .originURL: "https://www.example.com",
                .name: "sample cookie",
                .value: "123131321",
                .path: "/"
            ])
            YHDebugLog("cookie: \(cookie)")
        } catch let e as YHError {
            YHErrorLog(e.desc)
            YHErrorLog(e.type)
        }
        
    }

    @Test func allCookies() async throws {
        YHDebugLog(YHAllCookies())
        #expect(YHAllCookies() != nil)
    }

}
