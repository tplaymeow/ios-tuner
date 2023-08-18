import SwiftUI
import ComposableArchitecture
import AppFeature

@main
struct TunerApp: App {
  var body: some Scene {
    WindowGroup {
      AppView(store: self.store)
    }
  }

  private let store = Store(
    initialState: AppFeature.State()
  ) {
    AppFeature()
  }
}
