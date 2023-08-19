import Benchmark
@_spi(YIN) import PitchDetection

let yinSuite = BenchmarkSuite(name: "YIN") {
  $0.benchmark("difference") {
    _ = data.withUnsafeBufferPointer { buffer in
      YIN.difference(buffer: buffer)
    }
  }

  $0.benchmark("cumulativeDifference") {
    var buffer = data
    YIN.cumulativeDifference(buffer: &buffer)
  }

  $0.benchmark("absoluteThreshold") {
    _ = YIN.absoluteThreshold(
      buffer: data,
      threshold: 0.05
    )
  }

  $0.benchmark("process") {
    _ = data.withUnsafeBufferPointer { buffer in
      YIN.process(buffer: buffer, sampleRate: 512.0)
    }
  }
}
