import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
  @IBOutlet weak var scrollView: UIScrollView!

  // Width of each subview relative to the scroll view width
  let subviewWidthRatio: CGFloat = 0.8
  
  // The number of content views we want to show in the scroll view
  let numberOfSubviews = 10
  
  // Will contain one of the subviews. It will be used for get the width of a subview
  // for calculating the scroll view offset
  var aSubview = UIView()
  
  // Will contain one of the spacers. It will be used for get the width of a subview
  // for calculating the scroll view offset.
  var aSpacer = UIView()

  override func viewDidLoad() {
    super.viewDidLoad()

    scrollView.delegate = self
    scrollView.showsHorizontalScrollIndicator = false
    
    // Makes scroll view speed close to the one in the paged scroll view mode
    scrollView.decelerationRate = UIScrollViewDecelerationRateFast

    addViews()
  }
  
  /// Add all the subviews to the scroll view
  private func addViews() {
    // Create subviews
    var subviews = (1...numberOfSubviews).map { _ in addSingleView() }
    
    aSubview = subviews.first ?? UIView()
    
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
    aSpacer = frontSpacerView
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
    
    var spacerWidthRatio: CGFloat = (1 - subviewWidthRatio) / 2
    
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
  
  // MARK: - Calculating scroll view offset
  
  /// Current width of a subview
  var subviewWidth: CGFloat {
    return aSubview.bounds.width
  }
  
  /// Current width of a spacer
  var spacerWidth: CGFloat {
    return aSpacer.bounds.width
  }
  
  /// Returns the page number for a given scroll view offset.
  func calculatePageBasedOnOffset(var offset: CGFloat) -> CGFloat {
    offset -= spacerWidth
    return offset / subviewWidth
  }
  
  /// Returns the offset needed to display the given page
  func calculateOffsetBasedOnPage(page: Int) -> CGFloat {
    return CGFloat(page) * subviewWidth
  }
  
  func isLastPage(page: Int) -> Bool {
    return page == numberOfSubviews - 1
  }
  
  // MARK: UIScrollViewDelegate
  // ------------------------------
  
  // Show the views at the center of the screen after user has finished scrolling.
  func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint,
    targetContentOffset: UnsafeMutablePointer<CGPoint>) {
      
    let page = calculatePageBasedOnOffset(targetContentOffset.memory.x)
    var correctedOffset = calculateOffsetBasedOnPage(Int(round(page)))
      
    if isLastPage(Int(round(page))) {
      // Workaround a bug that prevents scrolling to the last page from the second to last page
      correctedOffset -= 2
    }
      
    targetContentOffset.memory.x = correctedOffset
  }
}

