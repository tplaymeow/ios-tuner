import SwiftUI
import ComposableArchitecture

public struct AppView: View {
  public var body: some View {
    WithViewStore(self.store, observe: \.pitch) { viewStore in
      Text(viewStore.state.frequency.formatted())
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
