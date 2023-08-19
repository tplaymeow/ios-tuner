import AVFoundation

public enum PitchDetection {
  public enum Error: Swift.Error {
    case emptyData
  }

  public static func process(
    buffer: AVAudioPCMBuffer,
    time: AVAudioTime
  ) throws -> Pitch {
    guard let data = buffer.floatChannelData else {
      throw Error.emptyData
    }

    let bufferPointer = UnsafeBufferPointer(
      start: data.pointee,
      count: Int(buffer.frameLength)
    )

    return Pitch(
      frequency: YIN.process(
        buffer: bufferPointer,
        sampleRate: Float(time.sampleRate)
      )
    )
  }
}
