import XCTestDynamicOverlay

extension MicrophoneMonitoringClient {
  public static var unimplemented: Self {
    Self(
      start: XCTestDynamicOverlay.unimplemented("\(Self.self).start"),
      finish: XCTestDynamicOverlay.unimplemented("\(Self.self).finish")
    )
  }
}

extension MicrophoneMonitoringClient {
  public static var dummy: Self {
    Self(
      start: { .never },
      finish: {}
    )
  }
}
