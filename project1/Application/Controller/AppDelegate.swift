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
            realmInstance.add(Girl(
                name: "Анджелина Джоли",
                biography: "Анджелина Джоли родилась в 1965 и бла бла бла",
                link: "https://ru.wikipedia.org/wiki/Джоли,_Анджелина"))
            realmInstance.add(Girl(
                name: "Скарлетт Йоханссон",
                biography: "Скарлетт Йоханссон родилась в 1965 и бла бла бла",
                link: "https://ru.wikipedia.org/wiki/Джоли,_Анджелина"))
            realmInstance.add(Girl(
                name: "Меган Фокс",
                biography: "Меган Фокс родилась в 1965 и бла бла бла",
                link: "https://ru.wikipedia.org/wiki/Джоли,_Анджелина"))
            realmInstance.add(Girl(
                name: "Шарлиз Терон",
                biography: "Шарлиз Терон родилась в 1965 и бла бла бла",
                link: "https://ru.wikipedia.org/wiki/Джоли,_Анджелина"))
            realmInstance.add(Girl(
                name: "Моника Беллуччи",
                biography: "Моника Беллуччи родилась в 1965 и бла бла бла",
                link: "https://ru.wikipedia.org/wiki/Джоли,_Анджелина"))
            realmInstance.add(Girl(
                name: "Натали Портман",
                biography: "Натали Портман родилась в 1965 и бла бла бла",
                link: "https://ru.wikipedia.org/wiki/Джоли,_Анджелина"))
            realmInstance.add(Girl(
                name: "Мила Кунис",
                biography: "Мила Кунис родилась в 1965 и бла бла бла",
                link: "https://ru.wikipedia.org/wiki/Джоли,_Анджелина"))
            realmInstance.add(Girl(
                name: "Кира Найтли",
                biography: "Кира Найтли родилась в 1965 и бла бла бла",
                link: "https://ru.wikipedia.org/wiki/Джоли,_Анджелина"))
            realmInstance.add(Girl(
                name: "Дженнифер Лоуренс",
                biography: "женнифер Лоуренс родилась в 1965 и бла бла бла",
                link: "https://ru.wikipedia.org/wiki/Джоли,_Анджелина"))
            realmInstance.add(Girl(
                name: "Марго Робби",
                biography: "Марго РоббиМарго Робби родилась в 1965 и бла бла бла",
                link: "https://ru.wikipedia.org/wiki/Джоли,_Анджелина"))
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
