import ComposableArchitecture
import AudioSessionClient
import MicrophoneMonitoringClient
import PitchDetection

public struct AppFeature: Reducer {
  public struct State {
    public var appearedOnce: Bool = false
    public var pitch: Pitch = Pitch(frequency: 0.0)

    public init() { }
  }

  public enum Action { 
    case onAppear
    case recordPermissionResult(Bool)
    case setPitch(Pitch)
  }

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        if state.appearedOnce {
          return .none
        } else {
          state.appearedOnce = true
          return .run { send in
            await send(
              .recordPermissionResult(
                self.audioSession.requestRecordPermission()
              )
            )
          }
        }

      case .recordPermissionResult(true):
        return .run { send in
          let stream = try await self.microphoneMonitor.start()
          for await (buffer, time) in stream {
            let pitch = try PitchDetection.process(buffer: buffer, time: time)
            await send(.setPitch(pitch))
          }
        } catch: { error, send in
          // TODO: Handle error
        }

      case .recordPermissionResult(false):
        return .none

      case let .setPitch(newValue):
        state.pitch = newValue
        return .none
      }
    }
  }

  public init() { }

  @Dependency(\.audioSession)
  private var audioSession

  @Dependency(\.microphoneMonitoring)
  private var microphoneMonitor
}
