import XCTest

public func XCTAssertEqual<C, T>(
  _ expression1: @autoclosure () -> C,
  _ expression2: @autoclosure () -> C,
  accuracy: T,
  _ message: @autoclosure () -> String = "",
  file: StaticString = #filePath,
  line: UInt = #line
) where C: Collection, T: FloatingPoint, C.Element == T {
  let collection1 = expression1()
  let collection2 = expression2()
  let message = message()

  XCTAssertEqual(
    collection1.count,
    collection2.count,
    message,
    file: file,
    line: line
  )

  for (element1, element2) in zip(collection1, collection2) {
    XCTAssertEqual(
      element1,
      element2,
      accuracy: accuracy,
      message,
      file: file,
      line: line
    )
  }
}
