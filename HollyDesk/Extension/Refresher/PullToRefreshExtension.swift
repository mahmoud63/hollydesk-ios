
import Foundation
import UIKit

private let pullToRefreshTag = 324
private let pullToRefreshDefaultHeight: CGFloat = 50

extension UIScrollView {
    
    // Actual UIView subclass which is added as subview to desired UIScrollView. If you want customize appearance of this object, do that after addPullToRefreshWithAction
    public var pullToRefreshView: PullToRefreshView? {
        get {
            let pullToRefreshView = viewWithTag(pullToRefreshTag)
            return pullToRefreshView as? PullToRefreshView
        }
    }
    
    // If you want to add pull to refresh functionality to your UIScrollView just call this method and pass action closure you want to execute while pull to refresh is animating. If you want to stop pull to refresh you must do that manually calling stopPullToRefreshView methods on your scroll view
    public func addPullToRefreshWithAction(_ action: @escaping (() -> ())) {
        let pullToRefreshView = PullToRefreshView(action: action, frame: CGRect(x: 0, y: -pullToRefreshDefaultHeight, width: self.frame.size.width, height: pullToRefreshDefaultHeight))
        pullToRefreshView.tag = pullToRefreshTag
        addSubview(pullToRefreshView)
    }
    
    // If you want to use your custom animation and custom subview when pull to refresh is animating, you should call this method and pass your animator and view objects.
    public func addPullToRefreshWithAction(_ action: @escaping (() -> ()), withAnimator animator: PullToRefreshViewDelegate, withSubview subview: UIView) {
        let height = subview.frame.height
        let pullToRefreshView = PullToRefreshView(action: action, frame: CGRect(x: 0, y: -height, width: self.frame.size.width, height: height), animator: animator, subview: subview)
        pullToRefreshView.tag = pullToRefreshTag
        addSubview(pullToRefreshView)
    }
    
    //
    public func addPullToRefreshWithAction<T: UIView>(_ action: @escaping (() -> ()), withAnimator animator: T) where T: PullToRefreshViewDelegate {
        let height = animator.frame.height
        let pullToRefreshView = PullToRefreshView(action: action, frame: CGRect(x: 0, y: -height, width: self.frame.size.width, height: height), animator: animator, subview: animator)
        pullToRefreshView.tag = pullToRefreshTag
        addSubview(pullToRefreshView)
    }
    
    // Manually start pull to refresh
    public func startPullToRefresh() {
        pullToRefreshView?.loading = true
    }
    
    // Manually stop pull to refresh
    public func stopPullToRefresh() {
        pullToRefreshView?.loading = false
    }
}
