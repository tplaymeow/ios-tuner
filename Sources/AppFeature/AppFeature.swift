import ComposableArchitecture
import InstrumentFeature
import AudioSessionClient
import MicrophoneMonitoringClient
import PitchDetection

public struct AppFeature: Reducer, Sendable {
  public struct State: Equatable {
    public var appearedOnce: Bool = false
    public var instruments: InstrumentsFeature.State = .guitar(.init(configuration: .init(
      target1: .init(pitchClass: .E, octave: 2),
      target2: .init(pitchClass: .A, octave: 2),
      target3: .init(pitchClass: .D, octave: 3),
      target4: .init(pitchClass: .G, octave: 3),
      target5: .init(pitchClass: .B, octave: 3),
      target6: .init(pitchClass: .E, octave: 4)
    )))

    public init() { }
  }

  public enum Action: Sendable{
    case onAppear
    case recordPermissionResult(Bool)
    case setClosestNote(ClosestNote?)
    case instruments(InstrumentsFeature.Action)
  }

  public var body: some ReducerOf<Self> {
    Scope(state: \.instruments, action: /Action.instruments) {
      InstrumentsFeature()
    }

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
        return .run { [targetNotes = state.instruments.targetNotes] send in
          let stream = try await self.microphoneMonitor.start()
          for await (buffer, time) in stream {
            let pitch = try PitchDetection.process(buffer: buffer, time: time)
            let closest = pitch.closest(of: targetNotes)
            await send(.setClosestNote(closest))
          }
        } catch: { error, send in
          // TODO: Handle error
        }

      case .recordPermissionResult(false):
        return .none

      case let .setClosestNote(newValue):
        state.instruments.select(note: newValue?.note)
        return .none

      case .instruments:
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
