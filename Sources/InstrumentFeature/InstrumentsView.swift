import ComposableArchitecture
import SceneKit
import SwiftUI

public struct InstrumentsView: View {
  public var body: some View {
    SwitchStore(self.store) { state in
      switch state {
      case .guitar:
        CaseLet(/InstrumentsFeature.State.guitar, action: InstrumentsFeature.Action.guitar) {
          store in
          let proxy = GuitarSceneProxy(store: store)
          SceneView(scene: proxy.scene, pointOfView: proxy.camera)
        }

      case .ukulele:
        CaseLet(/InstrumentsFeature.State.ukulele, action: InstrumentsFeature.Action.ukulele) {
          store in
          let proxy = UkuleleSceneProxy(store: store)
          SceneView(scene: proxy.scene, pointOfView: proxy.camera)
        }
      }
    }
  }

  public init(store: StoreOf<InstrumentsFeature>) {
    self.store = store
  }

  private let store: StoreOf<InstrumentsFeature>
}
