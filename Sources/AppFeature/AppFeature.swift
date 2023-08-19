import ComposableArchitecture
import AudioSessionClient
import MicrophoneMonitoringClient
import PitchDetection

public struct AppFeature: Reducer {
  public struct State {
    public var appearedOnce: Bool = false
    public var closestNote: ClosestNote?
    public var targetNotes: Set<Note> = [
      Note(pitchClass: .E, octave: 2),
      Note(pitchClass: .A, octave: 2),
      Note(pitchClass: .D, octave: 3),
      Note(pitchClass: .G, octave: 3),
      Note(pitchClass: .B, octave: 3),
      Note(pitchClass: .E, octave: 4),
    ]

    public init() { }
  }

  public enum Action { 
    case onAppear
    case recordPermissionResult(Bool)
    case setClosestNote(ClosestNote?)
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
        return .run { [targetNotes = state.targetNotes] send in
          let stream = try await self.microphoneMonitor.start()
          for await (buffer, time) in stream {
            let closest = try PitchDetection.process(buffer: buffer, time: time)
              .closest(of: targetNotes)
            await send(.setClosestNote(closest))
          }
        } catch: { error, send in
          // TODO: Handle error
        }

      case .recordPermissionResult(false):
        return .none

      case let .setClosestNote(newValue):
        state.closestNote = newValue
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
