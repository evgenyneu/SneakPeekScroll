
import UIKit

// View added as a subview in a scroll view
class ContentView: UIView {
  convenience init() {
    self.init(frame: CGRect())
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}