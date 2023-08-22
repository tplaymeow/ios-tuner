@_spi(YIN) import PitchDetection
import TestHelpers
import XCTest

final class YINTests: XCTestCase {
  func testDifferenceResult() {
    let input: [Float] = [
      1.0, 2.0, 3.0, 4.0, 5.0,
      5.0, 4.0, 3.0, 2.0, 1.0,
      1.0, 2.0, 3.0, 4.0, 5.0,
      5.0, 4.0, 3.0, 2.0, 1.0,
    ]

    let result = input.withUnsafeBufferPointer { buffer in
      YIN.difference(buffer: buffer)
    }

    let expectedResult: [Float] = [
      0.0, 8.0, 28.0, 52.0, 72.0,
      80.0, 72.0, 52.0, 28.0, 8.0,
    ]

    XCTAssertEqual(result, expectedResult, accuracy: 0.0001)
  }

  func testDifferenceCount() {
    let input4: [Float] = .init(count: 4) {
      Float.random(in: -100...100)
    }
    let input20: [Float] = .init(count: 20) {
      Float.random(in: -100...100)
    }
    let input100: [Float] = .init(count: 100) {
      Float.random(in: -100...100)
    }
    let input111: [Float] = .init(count: 111) {
      Float.random(in: -100...100)
    }

    let result4 = input4.withUnsafeBufferPointer { buffer in
      YIN.difference(buffer: buffer)
    }
    let result20 = input20.withUnsafeBufferPointer { buffer in
      YIN.difference(buffer: buffer)
    }
    let result100 = input100.withUnsafeBufferPointer { buffer in
      YIN.difference(buffer: buffer)
    }
    let result111 = input111.withUnsafeBufferPointer { buffer in
      YIN.difference(buffer: buffer)
    }

    XCTAssertEqual(result4.count, 2)
    XCTAssertEqual(result20.count, 10)
    XCTAssertEqual(result100.count, 50)
    XCTAssertEqual(result111.count, 55)
  }

  func testCumulativeDifference() {
    var result: [Float] = [
      0.0, 8.0, 28.0, 52.0, 72.0,
      80.0, 72.0, 52.0, 28.0, 8.0,
    ]

    YIN.cumulativeDifference(buffer: &result)

    let expectedResult: [Float] = [
      1.0, 1.0, 1.55555, 1.7727, 1.8,
      1.6667, 1.3846, 1.0, 0.57144, 0.18,
    ]

    XCTAssertEqual(result, expectedResult, accuracy: 0.0001)
  }

  func testAbsoluteThreshold() {
    let input: [Float] = [
      0.19408634, 0.18911031, 0.1849697,
      0.17890108, 0.17154595, 0.16554682,
      0.15745702, 0.14884186, 0.14115384,
      0.13209678, 0.121554695, 0.11007347,
      0.09797215, 0.08442398, 0.07124712,
      0.059738938, 0.04737826, 0.035116535,
      0.02484826, 0.015810769, 0.006254709,
      -0.0035861088, -0.012955923, -0.023592345,
      -0.033196256, -0.04131842, -0.050948877,
      -0.060684625, -0.07104337, -0.08273096,
      -0.09327866, -0.10242894, -0.1114612,
    ]

    let result = YIN.absoluteThreshold(
      buffer: input,
      threshold: 0.03
    )

    XCTAssertEqual(result, 32)
  }

  func testProcess() {

  }
}

extension Array {
  fileprivate init(count: Int, filling fill: () -> Element) {
    self = (0..<count).map { _ in fill() }
  }
}
