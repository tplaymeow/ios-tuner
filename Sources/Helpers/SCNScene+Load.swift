import SceneKit

extension SCNScene {
  public static func load(
    file: String,
    bundle: Bundle
  ) -> Self? {
    guard
      let url = bundle.url(forResource: file, withExtension: "scn"),
      let data = try? Data(contentsOf: url),
      let unarchiver = try? NSKeyedUnarchiver(forReadingFrom: data)
    else {
      return nil
    }

    let clazz: AnyClass = Self.classForKeyedUnarchiver()
    unarchiver.setClass(clazz, forClassName: "SKScene")
    unarchiver.requiresSecureCoding = false
    defer {
      unarchiver.finishDecoding()
    }

    return unarchiver.decodeObject(
      forKey: NSKeyedArchiveRootObjectKey
    ) as? Self
  }
}
