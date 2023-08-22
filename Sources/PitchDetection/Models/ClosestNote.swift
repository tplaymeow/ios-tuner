public struct ClosestNote: Equatable, Sendable {
  public let pitch: Pitch
  public let note: Note

  @inlinable
  public var distanceToNote: NoteDistance {
    NoteDistance.between(from: self.pitch, to: self.note)
  }

  @inlinable
  public init(pitch: Pitch, note: Note) {
    self.pitch = pitch
    self.note = note
  }
}
