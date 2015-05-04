//
//  AppDelegate.swift
//  Techeria
//  Created by Jordan Melberg
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    var navigationBarAppearace = UINavigationBar.appearance()
    navigationBarAppearace.tintColor = UIColor.whiteColor()
    navigationBarAppearace.barTintColor = UIColor(red:1.0, green:0.44, blue:0.0, alpha:1.0)

    return true
  }
    
}

