//
//  AppDelegate.swift
//  TinkoffChat
//
//  Created by MacBookPro on 21/02/2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var previousAppState = UIApplication.shared.applicationState

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        appTransition(funcName: #function)
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        
//        if let _window = window {
//            _window.rootViewController = ViewController()
//            _window.makeKeyAndVisible()
//        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        appTransition(funcName: #function)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        appTransition(funcName: #function)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        appTransition(funcName: #function)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        appTransition(funcName: #function)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        appTransition(funcName: #function)
    }

    func appTransition(funcName: String = "") {
        let newAppState = UIApplication.shared.applicationState
        print("Application moved from \(stateStr(previousAppState)) to \(stateStr(newAppState)): \(funcName)")
        previousAppState = newAppState
    }
    
    func stateStr(_ state: UIApplicationState) -> String {
        switch state {
        case .active:
            return "Active"
        case .inactive:
            return "Inactive"
        case .background:
            return "Background"
        }
    }

}

