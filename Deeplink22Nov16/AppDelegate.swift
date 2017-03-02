//
//  AppDelegate.swift
//  Deeplink22Nov16
//
//  Created by Puneeth Kumar  on 22/11/16.
//  Copyright © 2016 ASM Technologies Limited. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var loadedEnoughToDeepLink: Bool = false
    var deepLink : RemoteNotificationDeepLink?
    
    
    fileprivate func application(_ application: UIApplication, openURL url:URL, sourceApplication: String?, annotation:AnyObject?) -> Bool {
        
        if url.host == nil {
            return true;
        }
        
        let urlString = url.absoluteString
        let queryArray = urlString.components(separatedBy: "/")
        let query = queryArray[2]
        
        //Check if article
        if query.range(of: "article") != nil {
            let data = urlString.components(separatedBy: "/")
            
            if data.count>3 {
                let parameter = data[3]
                let userInfo = [RemoteNotificationDeepLinkAppSectionKey : parameter]
                self.applicationHandleRemoteNotification(application, didReceiveRemoteNotification: userInfo as [AnyHashable: Any])
            }
        }
        
        return true
    }
    
    fileprivate func applicationHandleRemoteNotification(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any])
    {
        if application.applicationState == UIApplicationState.background || application.applicationState == UIApplicationState.inactive
        {
            let canDoNow = loadedEnoughToDeepLink
            
            self.deepLink = RemoteNotificationDeepLink.create(userInfo as [AnyHashable: Any])
            
            if canDoNow
            {
                self.triggerDeepLinkIfPresent()
            }
        }
    }
    
    func triggerDeepLinkIfPresent() -> Bool
    {
        self.loadedEnoughToDeepLink = true
        let ret = (self.deepLink?.trigger() != nil)
        self.deepLink = nil
        return ret
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

