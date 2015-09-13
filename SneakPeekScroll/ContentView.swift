
import UIKit

// View added as a subview in a scroll view
class ContentView: UIView {
  convenience init(pageIndex: Int) {
    self.init(frame: CGRect())
    
    createImageView(pageIndex)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  private func createImageView(pageIndex: Int) {
    let image = UIImage(named: iiImages.imageName(pageIndex))
    let imageView = UIImageView(image: image)
    imageView.contentMode = .ScaleAspectFill
    imageView.clipsToBounds = true
    
    addSubview(imageView)
    
    layoutImageView(imageView)
  }
  
  private func layoutImageView(imageView: UIImageView) {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    // Make the image fill the width and height of the parent.
    // Add a horizontal margin.
    
    iiAutolayoutConstraints.fillParent(imageView, parentView: self, margin: 10, vertically: false)
    iiAutolayoutConstraints.fillParent(imageView, parentView: self, margin: 0, vertically: true)
  }
}