import Testing
@testable import YHSwifter

@Test func logger() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    YHDebugLog("This debug log.")
    YHInfoLog("This is info log.")
    YHWarningLog("This is warning log.")
    YHErrorLog("This is error log.")
}
