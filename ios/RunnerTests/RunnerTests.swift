import Flutter
import integration_test
import UIKit
import XCTest

class RunnerTests: XCTestCase {

  func testIntegrationTest() {
    var testResult: NSString?
    let testPass = IntegrationTestIosTest().testIntegrationTest(&testResult)
    XCTAssertTrue(testPass, testResult as String? ?? "Integration test failed")
  }

}
