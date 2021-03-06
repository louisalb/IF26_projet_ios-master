//
//  AppDelegate.swift
//  if26_projet_ios
//
//  Created by Thomas LS on 04/12/2018.
//  Copyright © 2018 if26. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        // Assuming your storyboard is named "Main"
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Add code here (e.g. if/else) to determine which view controller class (chooseViewControllerA or chooseViewControllerB) and storyboard ID (chooseStoryboardA or chooseStoryboardB) to send the user to
        let defaults = UserDefaults.standard
        let savedPseudo:String = defaults.object(forKey: "Session en cours") as? String ?? ""
        if !(savedPseudo.isEmpty){
            let initialViewController: MapViewController = mainStoryboard.instantiateViewController(withIdentifier: "Map View") as! MapViewController
            
            self.window?.rootViewController = initialViewController
            
        }else{
            let initialViewController: HomeViewController = mainStoryboard.instantiateViewController(withIdentifier: "Home") as! HomeViewController
            self.window?.rootViewController = initialViewController
        }
            
            self.window?.makeKeyAndVisible()
            
            return true
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

