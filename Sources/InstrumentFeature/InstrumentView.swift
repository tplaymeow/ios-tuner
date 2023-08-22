import SwiftUI
import SceneKit
import ComposableArchitecture

struct InstFeature: Reducer {
  struct State {
    var guitar: InstrumentState6 = .init(configuration: .init(
      target1: .init(pitchClass: .E, octave: 2),
      target2: .init(pitchClass: .A, octave: 2),
      target3: .init(pitchClass: .D, octave: 3),
      target4: .init(pitchClass: .G, octave: 3),
      target5: .init(pitchClass: .B, octave: 3),
      target6: .init(pitchClass: .E, octave: 4)
    ))
  }

  enum Action {
    case set1
    case set2
    case set3
    case set4
    case set5
    case set6
    case setNone
    case guitar(InstrumentAction)
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .set1:
        state.guitar.target = .target1
        return .none
      case .set2:
        state.guitar.target = .target2
        return .none
      case .set3:
        state.guitar.target = .target3
        return .none
      case .set4:
        state.guitar.target = .target4
        return .none
      case .set5:
        state.guitar.target = .target5
        return .none
      case .set6:
        state.guitar.target = .target6
        return .none
      case .setNone:
        state.guitar.target = .none
        return .none
      case .guitar:
        return .none
      }
    }
  }
}

public struct InstrumentView: View {
  let store: StoreOf<InstFeature>
  let guitar: GuitarSceneProxy

  public init() {
    let store = Store(initialState: .init()) { InstFeature() }
    self.store = store
    self.guitar = GuitarSceneProxy(
      store: store.scope(state: \.guitar, action: InstFeature.Action.guitar)
    )
  }

  public var body: some View {
    VStack {
      SceneView(
        scene: self.guitar.scene,
        pointOfView: self.guitar.camera
      )
      Button("Reset") {
        self.store.send(.setNone)
      }
      HStack {
        Button("1") {
          self.store.send(.set1)
        }
        Button("2") {
          self.store.send(.set2)
        }
        Button("3") {
          self.store.send(.set3)
        }
        Button("4") {
          self.store.send(.set4)
        }
        Button("5") {
          self.store.send(.set5)
        }
        Button("6") {
          self.store.send(.set6)
        }
      }
    }
  }
}
