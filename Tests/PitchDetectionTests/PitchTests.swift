import XCTest
import PitchDetection

final class PitchTests: XCTestCase {
  func testClosestEmpty() {
    let pitch = Pitch(frequency: 30.86771) // B0
    XCTAssertNil(pitch.closest(of: .init()))
  }

  func testClosest() {
    let a0 = Note(pitchClass: .A, octave: 0)
    let b0 = Note(pitchClass: .B, octave: 0)
    let b1 = Note(pitchClass: .B, octave: 1)

    let pitch = Pitch(frequency: 30.86) // almost B0

    XCTAssertEqual(pitch.closest(of: [a0, b1, b0])?.note, b0)
    XCTAssertEqual(pitch.closest(of: [a0, b1])?.note, a0)
    XCTAssertEqual(pitch.closest(of: [b1])?.note, b1)
  }
}
