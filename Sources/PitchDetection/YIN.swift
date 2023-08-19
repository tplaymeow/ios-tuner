import AVFoundation
import Accelerate

@_spi(YIN)
public enum YIN {
  @_spi(YIN)
  public static func process(
    buffer: UnsafeBufferPointer<Float>,
    sampleRate: Float
  ) -> Float {
    var transformed = Self.difference(buffer: buffer)
    Self.cumulativeDifference(buffer: &transformed)
    let tau = Self.absoluteThreshold(buffer: transformed, threshold: 0.05)
    return if tau == 0 {
      0.0
    } else {
      sampleRate / Self.parabolicInterpolation(buffer: transformed, tau: tau)
    }
  }

  @_spi(YIN)
  public static func difference(
    buffer: UnsafeBufferPointer<Float>
  ) -> [Float] {
    guard 
      let bufferPointer = buffer.baseAddress
    else {
      return []
    }

    let halfCount = buffer.count / 2
    let length = vDSP_Length(halfCount)

    var result: [Float] = .init(repeating: 0.0, count: halfCount)
    var temp: [Float] = .init(repeating: 0.0, count: halfCount)
    var tempSquared: [Float] = .init(repeating: 0.0, count: halfCount)

    var sum: Float = 0.0

    for tau in 0..<halfCount {
      let bufferTau = bufferPointer.advanced(by: tau)
      vDSP_vsub(bufferPointer, 1, bufferTau, 1, &temp, 1, length)
      vDSP_vsq(temp, 1, &tempSquared, 1, length)
      vDSP_sve(tempSquared, 1, &sum, length)
      result[tau] = sum
    }

    return result
  }

  @_spi(YIN)
  public static func cumulativeDifference(
    buffer: inout [Float]
  ) {
    guard !buffer.isEmpty else {
      return
    }

    buffer[0] = 1.0
    var runningSum: Float = 0.0

    for tau in 1..<buffer.count {
      runningSum += buffer[tau]

      if runningSum == 0 {
        buffer[tau] = 1
      } else {
        buffer[tau] *= Float(tau) / runningSum
      }
    }
  }

  @_spi(YIN)
  public static func absoluteThreshold(
    buffer: [Float],
    threshold: Float
  ) -> Int {
    var tau = 2
    var minTau = 0
    var minVal: Float = 1000.0

    while tau < buffer.count {
      if buffer[tau] < threshold {
        while tau + 1 < buffer.count && buffer[tau + 1] < buffer[tau] {
          tau += 1
        }
        return tau
      } else {
        if buffer[tau] < minVal {
          minVal = buffer[tau]
          minTau = tau
        }
      }
      tau += 1
    }

    if minTau > 0 {
      return -minTau
    }

    return 0
  }

  @_spi(YIN)
  public static func parabolicInterpolation(
    buffer: [Float],
    tau: Int
  ) -> Float {
    guard tau != buffer.count else {
      return Float(tau)
    }

    var betterTau: Float = 0.0

    if tau > 0  && tau < buffer.count - 1 {
      let s0 = buffer[tau - 1]
      let s1 = buffer[tau]
      let s2 = buffer[tau + 1]

      var adjustment = (s2 - s0) / (2.0 * (2.0 * s1 - s2 - s0))

      if abs(adjustment) > 1 {
        adjustment = 0
      }

      betterTau = Float(tau) + adjustment
    } else {
      betterTau = Float(tau)
    }

    return abs(betterTau)
  }

}
