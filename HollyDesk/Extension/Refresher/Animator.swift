
import Foundation
import QuartzCore
import UIKit

internal class AnimatorView: UIView {
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate let activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(titleLabel)
        addSubview(activityIndicatorView)
        
        let leftActivityConstraint = NSLayoutConstraint(item: activityIndicatorView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 16)
        let centerActivityConstraint = NSLayoutConstraint(item: activityIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        let leftTitleConstraint = NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: activityIndicatorView, attribute: .right, multiplier: 1, constant: 16)
        let centerTitleConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: titleLabel, attribute: .centerY, multiplier: 1, constant: 0)

        addConstraints([leftActivityConstraint, centerActivityConstraint, leftTitleConstraint, centerTitleConstraint])
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Animator: PullToRefreshViewDelegate {
    internal let animatorView: AnimatorView

    init(frame: CGRect) {
        animatorView = AnimatorView(frame: frame)
    }
    
    func pullToRefreshAnimationDidStart(_ view: PullToRefreshView) {
        animatorView.activityIndicatorView.startAnimating()
        animatorView.titleLabel.text = "Loading"
    }
    
    func pullToRefreshAnimationDidEnd(_ view: PullToRefreshView) {
        animatorView.activityIndicatorView.stopAnimating()
        animatorView.titleLabel.text = ""
    }
    
    func pullToRefresh(_ view: PullToRefreshView, progressDidChange progress: CGFloat) {
        
    }
    
    func pullToRefresh(_ view: PullToRefreshView, stateDidChange state: PullToRefreshViewState) {
        switch state {
        case .loading:
            animatorView.titleLabel.text = "Loading"
        case .pullToRefresh:
            animatorView.titleLabel.text = "Pull to refresh"
        case .releaseToRefresh:
            animatorView.titleLabel.text = "Release to refresh"
        }
    }
}
