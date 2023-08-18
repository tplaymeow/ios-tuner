import AVFoundation

extension AudioSessionClient {
  public static var shared: Self {
    let session = AVAudioSession.sharedInstance()
    return Self(
      requestRecordPermission: {
        await withCheckedContinuation { continuation in
          session.requestRecordPermission { granted in
            continuation.resume(returning: granted)
          }
        }
      },
      setupForRecording: {
        // FIXME: Not works
        //
        // try session.setCategory(
        //   .record,
        //   mode: .default,
        //   options: [.allowBluetoothA2DP, .allowBluetooth, .defaultToSpeaker]
        // )
        // try session.setActive(true, options: .notifyOthersOnDeactivation)
      }
    )
  }
}
