//
//  PresentationMode.swift
//  KozLibrary
//
//  Created by Kelvin Kosbab on 2/19/18.
//  Copyright © 2018 Kozinga. All rights reserved.
//

import UIKit

enum PresentationMode {
  case modal(UIModalPresentationStyle, UIModalTransitionStyle)
  case custom(CustomPresentationMode)
  case navStack
  
  var isNavStack: Bool {
    switch self {
    case .navStack:
      return true
    default:
      return false
    }
  }
}

enum CustomPresentationMode {
  case topDown
  case bottomUp
  case topKnobBottomUp
  case visualEffectFade
  case rightToLeft
  case leftMenu
  case appleMusic(sourceView: AppleMusicLargePlayerSourceProtocol?, destinationView: AppleMusicLargePlayerSourceProtocol?)
  
  var presentationAnimator: PresentableAnimator {
    return self.dissmissAnimator
  }
  
  var dissmissAnimator: PresentableAnimator {
    switch self {
    case .topDown:
      return TopDownAnimator()
    case .bottomUp:
      return BottomUpAnimator()
    case .topKnobBottomUp:
      return TopKnobBottomUpAnimator()
    case .visualEffectFade:
      return VisualEffectFadeAnimator()
    case .rightToLeft:
      return RightToLeftAnimator()
    case .leftMenu:
      return LeftMenuAnimator()
    case .appleMusic:
      return AppleMusicAnimator()
    }
  }
  
  func getPresentationController(forPresented presented: UIViewController, presenting: UIViewController) -> CustomPresentationController {
    switch self {
    case .topDown:
      return TopDownPresentationController(presentedViewController: presented, presenting: presenting)
    case .bottomUp:
      return BottomUpPresentationController(presentedViewController: presented, presenting: presenting)
    case .topKnobBottomUp:
      return TopKnobBottomUpPresentationController(presentedViewController: presented, presenting: presenting)
    case .visualEffectFade:
      return VisualEffectFadePresentationController(presentedViewController: presented, presenting: presenting)
    case .rightToLeft:
      return RightToLeftPresentationController(presentedViewController: presented, presenting: presenting)
    case .leftMenu:
      return LeftMenuPresentationController(presentedViewController: presented, presenting: presenting)
    case .appleMusic(sourceView: let sourceView, destinationView: let destinationView):
      let presentationController = AppleMusicPresentationController(presentedViewController: presented, presenting: presenting)
      presentationController.sourceView = sourceView
      presentationController.destinationView = destinationView
      return presentationController
    }
  }
}
