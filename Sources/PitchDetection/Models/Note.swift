import Foundation

public struct Note: Equatable, Hashable, Sendable {
  public enum PitchClass: Equatable, Sendable {
    case C
    case CSharp
    case D
    case DSharp
    case E
    case F
    case FSharp
    case G
    case GSharp
    case A
    case ASharp
    case B
  }

  public let pitchClass: PitchClass
  public let octave: Int

  @inlinable
  public var frequency: Float {
    frequencyC0 * powf(2.0, Float(self.semitonesFromC0) / 12.0)
  }

  @usableFromInline
  internal var semitonesFromC0: Int {
    let octaveNumber = 12 * self.octave
    let pitchClassNumber = switch self.pitchClass {
    case .C: 0
    case .CSharp: 1
    case .D: 2
    case .DSharp: 3
    case .E: 4
    case .F: 5
    case .FSharp: 6
    case .G: 7
    case .GSharp: 8
    case .A: 9
    case .ASharp: 10
    case .B: 11
    }
    return octaveNumber + pitchClassNumber
  }

  @inlinable
  public init(pitchClass: PitchClass, octave: Int) {
    self.pitchClass = pitchClass
    self.octave = octave
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

extension Note: Comparable {
  public static func < (lhs: Note, rhs: Note) -> Bool {
    lhs.semitonesFromC0 < rhs.semitonesFromC0
  }
}
