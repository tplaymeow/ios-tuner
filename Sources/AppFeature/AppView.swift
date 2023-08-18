import SwiftUI
import ComposableArchitecture

public struct AppView: View {
  public var body: some View {
    WithViewStore(self.store, observe: \.note) { viewStore in
      VStack {
        if let note = viewStore.state {
          Text(note.description)
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
