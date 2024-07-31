import Testing
@testable import YHSwifter

struct YHSwifterTests {
    @Test func logger() {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        YHDebugLog("This debug log.")
        YHInfoLog("This is info log.")
        YHWarningLog("This is warning log.")
        YHErrorLog("This is error log.")
    }

    @Test func bundleInfo() {
        let swifter = YHSwifter()
        YHDebugLog(swifter.appVersion)
        YHDebugLog(swifter.marketVersion())
    }


    @Test func allCookies() async throws {
        YHDebugLog(YHAllCookies())
        #expect(YHAllCookies() != nil)
    }

}
