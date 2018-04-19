//
//  AppDelegate.swift
//  BCSampleSwift
//
//  Created by Adrian Chojnacki on 14/12/16.
//  Copyright © 2016 Upnext. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var beaconCtrl: BCLBeaconCtrl?
    var tabBarController: BCTabBarController? {
        get {
            if let navigationController = self.window?.rootViewController as? UINavigationController {
                if let tabBarController = navigationController.topViewController as? BCTabBarController {
                    return tabBarController
                }
            }
            return nil
        }
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert,.sound,.badge],
                completionHandler: { (granted, error) in }
            )
            UNUserNotificationCenter.current().delegate = self
        } else {
            let notificationSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            application.registerUserNotificationSettings(notificationSettings)
        }
        
        // beacon ctrl configuration
        // the needed credentials can be found at https://beaconcontrol.io panel under Applications -> (Your application) -> Settings
//        BCLBeaconCtrl.setupBeaconCtrl(withClientId: YOUR_APP_CLIENT_ID, clientSecret: YOUR_APP_CLIENT_SECRET, userId: "testUser", pushEnvironment:BCLBeaconCtrlPushEnvironment.none, pushToken: nil) { beaconCtrl, isRestoredFromCache, error in
//            DispatchQueue.main.async {
//                if (error == nil) {
//                    self.beaconCtrl = beaconCtrl
//                    self.tabBarController?.set(beaconCtrl: beaconCtrl)
//                }
//            }
//        }


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
    
    //MARK: - UNUserNotificationCenter Delegate
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        do {
            try self.beaconCtrl?.handleNotification(response.notification.request.content.userInfo)
        } catch {}
    }
    
    //MARK: - Notifications
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        do {
            try self.beaconCtrl?.handleNotification(userInfo)
        } catch {}
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        do {
            try self.beaconCtrl?.handleNotification(notification.userInfo)
        } catch {}
    }
}

