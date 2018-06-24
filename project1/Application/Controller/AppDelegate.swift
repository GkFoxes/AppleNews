//
//  AppDelegate.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 16.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import RealmSwift

var realm : Realm!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 0.5)
    
        // Override point for customization after application launch.
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let splitViewController = mainStoryboard.instantiateViewController(withIdentifier: "StartSplitViewController") as! UISplitViewController
        UIApplication.shared.keyWindow?.rootViewController = splitViewController

        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController

        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self
        
        let tabBarViewController = self.window!.rootViewController as! UITabBarController
        //var splitViewController: UISplitViewController? = nil
        for viewController in tabBarViewController.viewControllers! {
            if viewController.title == "Detail" {
                _ = viewController as? UISplitViewController
            }
        }
        
        if !UserDefaults.standard.bool(forKey: "db_install") {
            self.girlInitial()
        }
        
        return true
    }
    
    func girlInitial() {
        let realmInstance = try! Realm()
        
        try! realmInstance.write {
            realmInstance.add(Girl(name: "Анджелина Джоли", girlID: 0))
            realmInstance.add(Girl(name: "Скарлетт Йоханссон", girlID: 1))
            realmInstance.add(Girl(name: "Меган Фокс", girlID: 2))
            realmInstance.add(Girl(name: "Шарлиз Терон", girlID: 3))
            realmInstance.add(Girl(name: "Моника Беллуччи", girlID: 4))
            realmInstance.add(Girl(name: "Натали Портман", girlID: 5))
            realmInstance.add(Girl(name: "Мила Кунис", girlID: 6))
            realmInstance.add(Girl(name: "Кира Найтли", girlID: 7))
            realmInstance.add(Girl(name: "Дженнифер Лоуренс", girlID: 8))
            realmInstance.add(Girl(name: "Марго Робби", girlID: 9))
        }
        
        UserDefaults.standard.set(true, forKey: "db_install")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    // MARK: - Split view
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? StartDetailViewController else { return false }
        if topAsDetailController.girlName == "" {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
           return true
        }
        return true
    }
}
