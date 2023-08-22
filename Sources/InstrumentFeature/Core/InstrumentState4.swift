import PitchDetection

public struct InstrumentState4: Equatable, InstrumentState {
  public struct Configuration: Equatable {
    public let target1: Note
    public let target2: Note
    public let target3: Note
    public let target4: Note

    public init(
      target1: Note,
      target2: Note,
      target3: Note,
      target4: Note
    ) {
      self.target1 = target1
      self.target2 = target2
      self.target3 = target3
      self.target4 = target4
    }
  }

  public enum Target: Equatable {
    case target1
    case target2
    case target3
    case target4
  }

  public var configuration: Configuration
  public var target: Target?

  public var targetNotes: Set<Note> {
    [
      self.configuration.target1,
      self.configuration.target2,
      self.configuration.target3,
      self.configuration.target4,
    ]
  }

  public var selectedNote: Note? {
    switch self.target {
    case .target1:
      self.configuration.target1
    case .target2:
      self.configuration.target2
    case .target3:
      self.configuration.target3
    case .target4:
      self.configuration.target4
    case .none:
      nil
    }
  }

  public init(
    configuration: Configuration,
    target: Target? = nil
  ) {
    self.configuration = configuration
    self.target = target
  }

  public mutating func select(note: Note?) {
    switch note {
    case self.configuration.target1:
      self.target = .target1
    case self.configuration.target2:
      self.target = .target2
    case self.configuration.target3:
      self.target = .target3
    case self.configuration.target4:
      self.target = .target4
    default:
      self.target = .none
    }
  }
}
