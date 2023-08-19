public struct NoteDistance: Equatable, Hashable {
  public let semitones: Float

  @inlinable
  public var cents: Float {
    self.semitones * 100.0
  }

  @inlinable
  public var absolute: Self {
    .init(semitones: abs(self.semitones))
  }

  @usableFromInline
  init(semitones: Float) {
    self.semitones = semitones
  }

  @inlinable
  public static func semitones(_ semitones: Float) -> Self {
    .init(semitones: semitones)
  }

  @inlinable
  public static func cents(_ cents: Float) -> Self {
    .init(semitones: cents / 100.0)
  }

  @inlinable
  public static func between(from: Note, to: Note) -> Self {
    .init(semitones: Float(to.semitonesFromC0 - from.semitonesFromC0))
  }

  @inlinable
  public static func between(from: Pitch, to: Note) -> Self {
    .init(semitones: Float(to.semitonesFromC0) - from.semitonesFromC0)
  }

  @inlinable
  public static func between(from: Note, to: Pitch) -> Self {
    .init(semitones: to.semitonesFromC0 - Float(from.semitonesFromC0))
  }

  @inlinable
  public static func between(from: Pitch, to: Pitch) -> Self {
    .init(semitones: to.semitonesFromC0 - from.semitonesFromC0)
  }
}

extension NoteDistance: Comparable {
  @inlinable
  public static func < (lhs: NoteDistance, rhs: NoteDistance) -> Bool {
    lhs.semitones < rhs.semitones
  }
}
