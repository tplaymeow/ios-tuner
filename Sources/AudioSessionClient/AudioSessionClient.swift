import AVFoundation
import Dependencies

extension DependencyValues {
  public var audioSession: AudioSessionClient {
    get { self[AudioSessionClient.self] }
    set { self[AudioSessionClient.self] = newValue }
  }
}

extension AudioSessionClient: DependencyKey {
  public static var liveValue: Self {
    .shared
  }

  public static var previewValue: Self {
    .dummy
  }

  public static var testValue: Self {
    .unimplemented
  }
}

public struct AudioSessionClient {
  public var requestRecordPermission: @Sendable () async -> Bool
  public var setupForRecording: @Sendable () async throws -> Void
}
