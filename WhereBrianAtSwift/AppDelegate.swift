//
//  AppDelegate.swift
//  WhereBrianAtSwift
//
//  Created by Brian Donohue on 6/3/14.
//  Copyright (c) 2014 Brian Donohue. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.rootViewController = MapViewController()
        self.window!.makeKeyAndVisible()
        return true
    }
}

