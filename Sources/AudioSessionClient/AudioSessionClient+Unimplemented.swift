import XCTestDynamicOverlay

extension AudioSessionClient {
  public static var unimplemented: Self {
    Self(
      requestRecordPermission: XCTestDynamicOverlay.unimplemented(
        "\(Self.self).requestRecordPermission"),
      setupForRecording: XCTestDynamicOverlay.unimplemented("\(Self.self).setupForRecording")
    )
  }
}

extension AudioSessionClient {
  public static var dummy: Self {
    Self(
      requestRecordPermission: { true },
      setupForRecording: {}
    )
  }
}
