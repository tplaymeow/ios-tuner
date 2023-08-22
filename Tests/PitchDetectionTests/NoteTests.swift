import PitchDetection
import XCTest

final class NoteTests: XCTestCase {
  func testFrequency() {
    // Expected values from: https://en.wikipedia.org/wiki/Piano_key_frequencies
    XCTAssertEqual(Note(pitchClass: .C, octave: 0).frequency, 16.35160, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .CSharp, octave: 0).frequency, 17.32391, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .D, octave: 0).frequency, 18.35405, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .DSharp, octave: 0).frequency, 19.44544, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .E, octave: 0).frequency, 20.60172, accuracy: 0.01)
    XCTAssertEqual(Note(pitchClass: .F, octave: 0).frequency, 21.82676, accuracy: 0.01)
    XCTAssertEqual(Note(pitchClass: .FSharp, octave: 0).frequency, 23.12465, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .G, octave: 0).frequency, 24.49971, accuracy: 0.01)
    XCTAssertEqual(Note(pitchClass: .GSharp, octave: 0).frequency, 25.95654, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .A, octave: 0).frequency, 27.50000, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .ASharp, octave: 0).frequency, 29.13524, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .B, octave: 0).frequency, 30.86771, accuracy: 0.0001)

    XCTAssertEqual(Note(pitchClass: .A, octave: 1).frequency, 55.0000, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .ASharp, octave: 1).frequency, 58.27047, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .B, octave: 1).frequency, 61.73541, accuracy: 0.0001)

    XCTAssertEqual(Note(pitchClass: .C, octave: 2).frequency, 65.40639, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .CSharp, octave: 2).frequency, 69.29566, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .D, octave: 2).frequency, 73.41619, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .DSharp, octave: 2).frequency, 77.78175, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .E, octave: 2).frequency, 82.40689, accuracy: 0.01)
    XCTAssertEqual(Note(pitchClass: .F, octave: 2).frequency, 87.30706, accuracy: 0.01)
    XCTAssertEqual(Note(pitchClass: .FSharp, octave: 2).frequency, 92.49861, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .G, octave: 2).frequency, 97.99886, accuracy: 0.01)
    XCTAssertEqual(Note(pitchClass: .GSharp, octave: 2).frequency, 103.8262, accuracy: 0.0001)

    XCTAssertEqual(Note(pitchClass: .A, octave: 3).frequency, 220.0000, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .ASharp, octave: 3).frequency, 233.0819, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .B, octave: 3).frequency, 246.9417, accuracy: 0.0001)

    XCTAssertEqual(Note(pitchClass: .C, octave: 4).frequency, 261.6256, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .CSharp, octave: 4).frequency, 277.1826, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .D, octave: 4).frequency, 293.6648, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .DSharp, octave: 4).frequency, 311.1270, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .E, octave: 4).frequency, 329.6276, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .F, octave: 4).frequency, 349.2282, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .FSharp, octave: 4).frequency, 369.9944, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .G, octave: 4).frequency, 391.9954, accuracy: 0.0001)
    XCTAssertEqual(Note(pitchClass: .GSharp, octave: 4).frequency, 415.3047, accuracy: 0.0001)

  }
}
