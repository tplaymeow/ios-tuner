import ComposableArchitecture
import PitchDetection

public struct InstrumentsFeature: Reducer {
  public enum State: Equatable {
    case guitar(InstrumentState6)
    case ukulele(InstrumentState4)

    public var targetNotes: Set<Note> {
      switch self {
      case let .guitar(state):
        state.targetNotes
      case let .ukulele(state):
        state.targetNotes
      }
    }

    public var selectedNote: Note? {
      switch self {
      case let .guitar(state):
        state.selectedNote
      case let .ukulele(state):
        state.selectedNote
      }
    }

    public mutating func select(note: Note?) {
      switch self {
      case var .guitar(guitar):
        guitar.select(note: note)
        self = .guitar(guitar)
      case var .ukulele(guitar):
        guitar.select(note: note)
        self = .ukulele(guitar)
      }
    }
  }

  public enum Action {
    case guitar(InstrumentAction)
    case ukulele(InstrumentAction)
  }

  public var body: some ReducerOf<Self> {
    EmptyReducer()
      .ifCaseLet(/State.guitar, action: /Action.guitar) {
        InstrumentFeature()
      }
      .ifCaseLet(/State.ukulele, action: /Action.ukulele) {
        InstrumentFeature()
      }
  }

  public init() { }
}
