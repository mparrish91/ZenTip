//
//  AppDelegate.swift
//  ZenTip
//
//  Created by parry on 7/31/16.
//  Copyright © 2016 MCP. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        UIApplication.sharedApplication().statusBarHidden = true

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = ZTTipViewController()
        window?.makeKeyAndVisible()


        return true
    }



}

