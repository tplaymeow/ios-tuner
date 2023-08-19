import SwiftUI
import ComposableArchitecture
import PitchDetection

public struct AppView: View {
  public var body: some View {
    WithViewStore(self.store, observe: \.closestNote) { viewStore in
      VStack {
        if let closestNote = viewStore.state {
          Text(closestNote.note.displayString)
            .bold()
          Text(closestNote.distanceToNote.cents.formatted())
          Text(closestNote.pitch.frequency.formatted())
        }
      }
      .onAppear{
        viewStore.send(.onAppear)
      }
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
