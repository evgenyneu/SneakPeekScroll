import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!

  // Width of each subview relative to the scroll view width
  let subviewWidthRatio: CGFloat = 0.8

  override func viewDidLoad() {
    super.viewDidLoad()

    addViews()
  }
  
  /// Add all the subviews to the scroll view
  private func addViews() {
    // Create subviews
    var subviews = (1...10).map { _ in addSingleView() }
    
    // Create two spacer views
    subviews = createSpacerViews(subviews)
    
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
  
  private func createSpacerViews(var subviews: [UIView]) -> [UIView] {
    //  Please the first one at the front
    let frontSpacerView = addSpacerView()
    subviews.insert(frontSpacerView, atIndex: 0)
    
    // Place the the other at the back of the subviews
    let backSpacerView = addSpacerView()
    subviews.append(backSpacerView)
    
    return subviews
  }
  
  /// Add a subview to the scroll view
  private func addSingleView() -> UIView {
    let subview = UIView()
    subview.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(subview)
    
    // Make the width of the subview equal to 'subviewWidthRatio' of the scroll view width
    iiAutolayoutConstraints.equalWidth(subview, viewTwo: scrollView,
      constraintContainer: scrollView, multiplier: subviewWidthRatio)
    
    // Make height of the subview the same as the scroll view
    iiAutolayoutConstraints.fillParent(subview, parentView: scrollView, margin: 0,
      vertically: true)
    
    // Center the subview vertically in the scroll view
    iiAutolayoutConstraints.alignSameAttributes(subview, toItem: scrollView,
      constraintContainer: scrollView, attribute: NSLayoutAttribute.CenterY)
    
    return subview
  }
  
  /// Add a view that that reserves a space in front of the first subview and after the last subview
  private func addSpacerView() -> UIView {
    let subview = UIView()
    subview.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(subview)
    
    let spacerWidthRatio = (1 - subviewWidthRatio) / 2
    
    // Make the width of the spacer view equal to 'spacerWidthRatio' of the scroll view width
    iiAutolayoutConstraints.equalWidth(subview, viewTwo: scrollView,
      constraintContainer: scrollView, multiplier: spacerWidthRatio)
    
    // Add a height constraint
    iiAutolayoutConstraints.height(subview, value: 10)
    
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
    view.backgroundColor = RandomColor.get
  }
  
  // Make the status bar light
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
}

