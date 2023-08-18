import AVFoundation

extension MicrophoneMonitoringClient {
  public static var liveValue: Self {
    let implementation = LiveImplementation()
    return Self(
      start: {
        try await implementation.start()
      },
      finish: {
        await implementation.finish()
      }
    )
  }
}

extension MicrophoneMonitoringClient {
  private actor LiveImplementation {
    func start() throws -> AsyncStream<(AVAudioPCMBuffer, AVAudioTime)> {
      let (stream, continuation) = AsyncStream<(AVAudioPCMBuffer, AVAudioTime)>.makeStream()

      let engine = AVAudioEngine()
      engine.inputNode.installTap(
        onBus: Self.bus,
        bufferSize: Self.bufferSize,
        format: engine.inputNode.outputFormat(forBus: Self.bus)
      ) { buffer, time in
        continuation.yield((buffer, time))
      }
      engine.prepare()
      try engine.start()

      self.engine = engine

      return stream
    }

    func finish() {
      self.engine?.stop()
      self.engine?.inputNode.removeTap(onBus: Self.bus)
      self.engine = nil
    }

    private var engine: AVAudioEngine?

    private static let bus: AVAudioNodeBus = 0
    private static let bufferSize: AVAudioFrameCount = 2048
  }
}

