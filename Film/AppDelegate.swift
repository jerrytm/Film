        //
//  AppDelegate.swift
//  Film
//
//  Created by Tomas Vosicky on 22.11.16.
//  Copyright © 2016 Tomas Vosicky. All rights reserved.
//

import UIKit
import MagicalRecord

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let tabBarController = TabsController()
        window?.rootViewController = tabBarController
        
        UINavigationBar.appearance().barTintColor = .background
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

        application.statusBarStyle = .lightContent
        
        MagicalRecord.setupCoreDataStack(withStoreNamed: "MovieModel")

        return true
    }
}

