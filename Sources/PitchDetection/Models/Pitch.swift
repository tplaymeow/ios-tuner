import Foundation

public struct Pitch: Equatable {
  public let frequency: Float

  @usableFromInline
  internal var semitonesFromC0: Float {
    12.0 * log2(self.frequency / frequencyC0)
  }

  @inlinable
  public init(frequency: Float) {
    self.frequency = frequency
  }

  @inlinable
  public func closest(of notes: Set<Note>) -> ClosestNote? {
    notes.min { left, right in
      let leftDistance = NoteDistance.between(from: self, to: left).absolute
      let rightDistance = NoteDistance.between(from: self, to: right).absolute
      return leftDistance < rightDistance
    }.map {
      ClosestNote(pitch: self, note: $0)
    }
  }

  @inlinable
  public func distance(to other: Note) -> NoteDistance {
    NoteDistance.between(from: self, to: other)
  }

  @inlinable
  public func distance(to other: Pitch) -> NoteDistance {
    NoteDistance.between(from: self, to: other)
  }
}
