import Dependencies
import AVFoundation

extension DependencyValues {
  public var microphoneMonitoring: MicrophoneMonitoringClient {
    get { self[MicrophoneMonitoringClient.self] }
    set { self[MicrophoneMonitoringClient.self] = newValue }
  }
}

extension MicrophoneMonitoringClient: DependencyKey {
  public static var previewValue: Self {
    .dummy
  }

  public static var testValue: Self {
    .unimplemented
  }
}

public struct MicrophoneMonitoringClient: Sendable {
  public var start: @Sendable () async throws -> AsyncStream<(AVAudioPCMBuffer, AVAudioTime)>
  public var finish: @Sendable () async -> Void
}
