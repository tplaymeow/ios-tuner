import Combine

extension Set where Element == AnyCancellable {
  @inlinable
  public func cancel() {
    self.forEach {
      $0.cancel()
    }
  }
}
