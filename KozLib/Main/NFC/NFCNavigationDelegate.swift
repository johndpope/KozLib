//
//  NFCNavigationDelegate.swift
//  KozLibrary
//
//  Created by Kelvin Kosbab on 10/1/17.
//  Copyright © 2017 Kozinga. All rights reserved.
//

import UIKit

protocol NFCNavigationDelegate {}
extension NFCNavigationDelegate where Self : UIViewController {
  
  func transitionToNFC(presentationMode: PresentationMode) {
    let viewController = NFCTableViewController.newViewController()
    viewController.presentIn(self, withMode: presentationMode)
  }
}
