import AVFoundation

extension AudioSessionClient {
  public static var shared: Self {
    Self(
      requestRecordPermission: {
        await withCheckedContinuation { continuation in
          AVAudioSession.sharedInstance().requestRecordPermission { granted in
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
