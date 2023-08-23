import ComposableArchitecture
import SceneKit
import SwiftUI

@MainActor
struct GuitarSceneView: View {
  var body: some View {
    SceneView(scene: self.proxy.scene, pointOfView: self.proxy.camera)
  }

  init(store: StoreOf<InstrumentFeature<InstrumentState6>>) {
    self.store = store
    self.proxy = GuitarSceneProxy(store: store)
  }

  private let store: StoreOf<InstrumentFeature<InstrumentState6>>
  private let proxy: GuitarSceneProxy
}

@MainActor
struct UkuleleSceneView: View {
  var body: some View {
    SceneView(scene: self.proxy.scene, pointOfView: self.proxy.camera)
  }

  init(store: StoreOf<InstrumentFeature<InstrumentState4>>) {
    self.store = store
    self.proxy = UkuleleSceneProxy(store: store)
  }

  private let store: StoreOf<InstrumentFeature<InstrumentState4>>
  private let proxy: UkuleleSceneProxy
}

public struct InstrumentsView: View {
  public var body: some View {
    SwitchStore(self.store) { state in
      switch state {
      case .guitar:
        CaseLet(/InstrumentsFeature.State.guitar, action: InstrumentsFeature.Action.guitar) {
          GuitarSceneView(store: $0)
        }

      case .ukulele:
        CaseLet(/InstrumentsFeature.State.ukulele, action: InstrumentsFeature.Action.ukulele) {
          UkuleleSceneView(store: $0)
        }
      }
    }
  }

  public init(store: StoreOf<InstrumentsFeature>) {
    self.store = store
  }

  private let store: StoreOf<InstrumentsFeature>
}
