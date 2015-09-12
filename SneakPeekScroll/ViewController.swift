import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!

  override func viewDidLoad() {
    super.viewDidLoad()

    addViews()
  }
  
  /// Add all the subviews to the scroll view
  private func addViews() {
    let subviews = (1...10).map { _ in addSingleView() }
    
    // Add constraints between the subviews so they are shown one after another
    iiAutolayoutConstraints.viewsNextToEachOther(subviews, constraintContainer: scrollView)
    
    // Align the leading edge of the first subview with the leading edge of the scroll view
    if let firstSubview = subviews.first {
      iiAutolayoutConstraints.alignSameAttributes(firstSubview, toItem: scrollView,
        constraintContainer: scrollView, attribute: NSLayoutAttribute.Leading)
    }
    
    // Align the trailing edge of the first subview with the trailing edge of the scroll view
    if let lastSubview = subviews.last {
      iiAutolayoutConstraints.alignSameAttributes(lastSubview, toItem: scrollView,
        constraintContainer: scrollView, attribute: NSLayoutAttribute.Trailing)
    }
    
    // Style the subview
    styleSubviews(subviews)
  }
  
  /// Add a subview to the scroll view
  private func addSingleView() -> UIView {
    let subview = UIView()
    subview.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(subview)
    
    // Make the width of the subview equal to 80% of the scroll view width
    iiAutolayoutConstraints.equalWidth(subview, viewTwo: scrollView,
      constraintContainer: scrollView, multiplier: 0.8)
    
    // Make heiht of the subview the same as the scroll view
    iiAutolayoutConstraints.fillParent(subview, parentView: scrollView, margin: 0,
      vertically: true)
    
    // Center the subview vertically in the scroll view
    iiAutolayoutConstraints.alignSameAttributes(subview, toItem: scrollView,
      constraintContainer: scrollView, attribute: NSLayoutAttribute.CenterY)
    
    return subview
  }
  
  private func styleSubviews(views: [UIView]) {
    for view in views {
      style(view)
    }
  }
  
  private func style(view: UIView) {
    view.backgroundColor = UIColor.redColor()
  }
}

