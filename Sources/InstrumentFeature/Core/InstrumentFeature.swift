import ComposableArchitecture

public struct InstrumentFeature<State: InstrumentState>: Reducer {
  public typealias State = State
  public typealias Action = InstrumentAction

  public var body: some ReducerOf<Self> {
    EmptyReducer()
  }
}
