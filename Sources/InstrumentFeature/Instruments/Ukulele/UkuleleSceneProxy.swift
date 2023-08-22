import Combine
import ComposableArchitecture
import Helpers
import SceneKit

@MainActor
final class UkuleleSceneProxy {
  lazy var scene: SCNScene? = {
    let result = SCNScene.load(file: "UkuleleScene", bundle: .module)
    assert(result != nil, "scene is nil")
    return result
  }()

  lazy var camera: SCNNode? = {
    let result = self.scene?.rootNode.childNode(withName: "camera", recursively: false)
    assert(result != nil, "camera is nil")
    return result
  }()

  init(store: StoreOf<InstrumentFeature<InstrumentState4>>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
    self.setup()
  }

  private let store: StoreOf<InstrumentFeature<InstrumentState4>>
  private let viewStore: ViewStoreOf<InstrumentFeature<InstrumentState4>>

  private var cancellables: Set<AnyCancellable> = .init()

  private lazy var cameraTarget: SCNNode? = {
    let result = self.scene?.rootNode.childNode(withName: "cameraTarget", recursively: false)
    assert(result != nil, "cameraTarget is nil")
    return result
  }()

  private func setup() {
    self.viewStore.publisher.target
      .sink { [weak self] target in
        guard let self else { return }
        self.update(target: target)
      }
      .store(in: &self.cancellables)
  }

  private func update(target: InstrumentState4.Target?) {
    switch target {
    case .target1:
      self.move(
        camera: .init(x: -10.0, y: 100.0, z: -30.0),
        cameraTarget: .init(x: -5.425, y: 96.114, z: -69.62)
      )

    case .target2:
      self.move(
        camera: .init(x: -10.0, y: 100.0, z: -30.0),
        cameraTarget: .init(-5.334, 100.658, -71.387)
      )

    case .target3:
      self.move(
        camera: .init(x: -10.0, y: 100.0, z: -30.0),
        cameraTarget: .init(x: -5.569, y: 104.647, z: -73.147)
      )

    case .target4:
      self.move(
        camera: .init(x: 10.0, y: 100.0, z: -30.0),
        cameraTarget: .init(x: 5.158, y: 104.624, z: -73.147)
      )

    case .none:
      self.move(
        camera: .init(x: 0.0, y: 100.0, z: -30.0),
        cameraTarget: .init(x: 0.0, y: 100.0, z: -40.0)
      )
    }
  }

  private func move(
    camera: SCNVector3,
    cameraTarget: SCNVector3
  ) {
    let duration: TimeInterval = 1.0

    let cameraMoveAction = SCNAction.move(to: camera, duration: duration)
    self.camera?.runAction(cameraMoveAction)

    let cameraTargetMoveAction = SCNAction.move(to: cameraTarget, duration: duration)
    self.cameraTarget?.runAction(cameraTargetMoveAction)
  }
}
