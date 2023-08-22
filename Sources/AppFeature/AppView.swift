import SwiftUI
import ComposableArchitecture
import PitchDetection
import InstrumentFeature

public struct AppView: View {
  public var body: some View {
    ZStack {
      InstrumentsView(
        store: self.store.scope(state: \.instruments, action: AppFeature.Action.instruments)
      )

      WithViewStore(self.store, observe: { $0 }) { viewStore in
        VStack {
          if let closestNote = viewStore.instruments.selectedNote {
            Text(closestNote.displayString)
              .bold()
          }
        }
      }
    }
    .onAppear{
      self.store.send(.onAppear)
    }
  }
  

  public init(store: StoreOf<AppFeature>) {
    self.store = store
  }

  private let store: StoreOf<AppFeature>
}

extension Note {
  fileprivate var displayString: String {
    let octave = self.octave.formatted()
    let pitchClass = switch self.pitchClass {
    case .A: "A"
    case .ASharp: "A#"
    case .B: "B"
    case .C: "C"
    case .CSharp: "C#"
    case .D: "D"
    case .DSharp: "D#"
    case .E: "E"
    case .F: "F"
    case .FSharp: "F#"
    case .G: "G"
    case .GSharp: "G#"
    }
    return "\(pitchClass)\(octave)"
  }
}
