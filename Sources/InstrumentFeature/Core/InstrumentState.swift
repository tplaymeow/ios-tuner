import PitchDetection

public protocol InstrumentState {
  associatedtype Configuration
  associatedtype Target

  var configuration: Configuration { get }
  var target: Target? { get }
  var targetNotes: Set<Note> { get }
  var selectedNote: Note? { get }

  mutating func select(note: Note?)
}
