import XCTest
import PitchDetection

final class NoteDistanceTests: XCTestCase {
  func testBetweenNotes() {
    let a0 = Note(pitchClass: .A, octave: 0)
    let b1 = Note(pitchClass: .B, octave: 1)

    XCTAssertEqual(NoteDistance.between(from: a0, to: b1).semitones, 14.0)
    XCTAssertEqual(NoteDistance.between(from: a0, to: b1).cents, 1400.0)
    XCTAssertEqual(NoteDistance.between(from: b1, to: a0).semitones, -14.0)
    XCTAssertEqual(NoteDistance.between(from: b1, to: a0).cents, -1400.0)
    XCTAssertEqual(NoteDistance.between(from: a0, to: a0).semitones, 0.0)
    XCTAssertEqual(NoteDistance.between(from: a0, to: a0).cents, 0.0)
  }

  func testBetweenNotePitch() {
    let note = Note(pitchClass: .A, octave: 0)
    let pitch = Pitch(frequency: 30.86771) // B0

    XCTAssertEqual(NoteDistance.between(from: note, to: pitch).semitones, 2.0, accuracy: 0.0001)
    XCTAssertEqual(NoteDistance.between(from: pitch, to: note).semitones, -2.0, accuracy: 0.0001)
    XCTAssertEqual(NoteDistance.between(from: note, to: pitch).cents, 200.0, accuracy: 0.001)
    XCTAssertEqual(NoteDistance.between(from: pitch, to: note).cents, -200.0, accuracy: 0.001)
  }

  func testCompare() {
    let a0 = Note(pitchClass: .A, octave: 0)
    let b1 = Note(pitchClass: .B, octave: 1)
    let c2 = Note(pitchClass: .C, octave: 2)

    let a0b1 = NoteDistance.between(from: a0, to: b1)
    let a0c2 = NoteDistance.between(from: a0, to: c2)

    XCTAssertTrue(a0b1 < a0c2)
    XCTAssertTrue(a0c2 > a0b1)
  }
}
