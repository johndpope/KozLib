//
//  BottomUpAnimator.swift
//  KozLibrary
//
//  Created by Kelvin Kosbab on 2/19/18.
//  Copyright © 2018 Kozinga. All rights reserved.
//

import UIKit

class BottomUpAnimator : NSObject, PresentableAnimator {
  
  // MARK: - PresentableAnimator
  
  weak var presentingViewControllerDelegate: PresentingViewControllerDelegate?
  weak var presentedViewControllerDelegate: PresentedViewControllerDelegate?
  
  // MARK: - UIViewControllerAnimatedTransitioning
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.3
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    guard let toViewController = transitionContext.viewController(forKey: .to), let fromViewController = transitionContext.viewController(forKey: .from) else {
      return
    }
    
    let isPresenting = toViewController.presentedViewController != fromViewController
    _ = isPresenting ? fromViewController : toViewController
    let presentedViewController = isPresenting ? toViewController : fromViewController
    let containerView = transitionContext.containerView
    
    // Preferred height of the presented controller
    let presentedYOffset: CGFloat = presentedViewController.preferredContentSize.height > 0 ? presentedViewController.preferredContentSize.height : containerView.bounds.height
    
    if isPresenting {
      
      // Currently presenting
      self.presentingViewControllerDelegate?.willPresentViewController(presentedViewController, usingMode: .custom(.bottomUp))
      self.presentedViewControllerDelegate?.willPresentViewController(usingMode: .custom(.bottomUp))
      presentedViewController.view.frame.origin.y = containerView.bounds.height
      containerView.addSubview(presentedViewController.view)
      
      // Animate the presentation
      UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
        presentedViewController.view.frame.origin.y -= presentedYOffset
        self.presentingViewControllerDelegate?.isPresentingViewController(presentedViewController, usingMode: .custom(.bottomUp))
        self.presentedViewControllerDelegate?.isPresentingViewController(usingMode: .custom(.bottomUp))
      }, completion: { _ in
        self.presentingViewControllerDelegate?.didPresentViewController(presentedViewController, usingMode: .custom(.bottomUp))
        self.presentedViewControllerDelegate?.didPresentViewController(usingMode: .custom(.bottomUp))
        transitionContext.completeTransition(true)
      })
      
    } else {
      
      // Currently dismissing
      self.presentingViewControllerDelegate?.willDismissViewController(presentedViewController, usingMode: .custom(.bottomUp))
      self.presentedViewControllerDelegate?.willDismissViewController(usingMode: .custom(.bottomUp))
      UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
        presentedViewController.view.frame.origin.y += presentedYOffset
        self.presentingViewControllerDelegate?.isDismissingViewController(presentedViewController, usingMode: .custom(.bottomUp))
        self.presentedViewControllerDelegate?.isDismissingViewController(usingMode: .custom(.bottomUp))
      }, completion: { _ in
        if transitionContext.transitionWasCancelled {
          self.presentingViewControllerDelegate?.didCancelDissmissViewController(presentedViewController, usingMode: .custom(.bottomUp))
          self.presentedViewControllerDelegate?.didCancelDissmissViewController(usingMode: .custom(.bottomUp))
        } else {
          self.presentingViewControllerDelegate?.didDismissViewController(presentedViewController, usingMode: .custom(.bottomUp))
          self.presentedViewControllerDelegate?.didDismissViewController(usingMode: .custom(.bottomUp))
        }
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      })
    }
  }
}
