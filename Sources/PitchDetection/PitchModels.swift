public struct Pitch: Equatable {
  public let frequency: Float

  public init(frequency: Float) {
    self.frequency = frequency
  }

  public var closetNote: (note: Note, cents: Int) {
    // TODO: Add impl
    (Note(pitchClass: .A, octave: 3), 0)
  }
}

public struct Note: Equatable, CustomStringConvertible {
  public let pitchClass: PitchClass
  public let octave: Int

  public init(pitchClass: PitchClass, octave: Int) {
    self.pitchClass = pitchClass
    self.octave = octave
  }

  public var description: String {
    "\(self.pitchClass)\(self.octave.formatted(.number))"
  }
}

extension Note {
  public enum PitchClass: Equatable, CustomStringConvertible {
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

    public var description: String {
      switch self {
      case .C: "C"
      case .CSharp: "C#"
      case .D: "D"
      case .DSharp: "D#"
      case .E: "E"
      case .F: "F"
      case .FSharp: "F#"
      case .G: "G"
      case .GSharp: "G#"
      case .A: "A"
      case .ASharp: "A#"
      case .B: "B"
      }
    }
  }
}
