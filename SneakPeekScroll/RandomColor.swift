import UIKit

/// Returns a randomly chosen UIColor
struct RandomColor {
  static var get: UIColor {
    return UIColor(
      red: randomColorComponent(),
      green: randomColorComponent(),
      blue: randomColorComponent(), alpha: 1.0)
  }

  private static func randomColorComponent() -> CGFloat {
    return CGFloat(arc4random_uniform(255)) / 255.0
  }
}