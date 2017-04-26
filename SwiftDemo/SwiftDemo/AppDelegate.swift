//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by feiyu iOS on 17/4/11.
//  Copyright © 2017年 Mwy Group. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .carPlay, .sound]) { (success, error) in
                
            }
        } else {
            // Fallback on earlier versions
            let notifySettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(notifySettings)
        }
        
        //sleep(2)

        
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = WBMainViewController()
        window?.makeKeyAndVisible()
        
         loadAppInfo()
        
        // Override point for customization after application launch.
        return true
    }


}


extension AppDelegate{
    fileprivate func loadAppInfo(){
        DispatchQueue.global().async {
            let url = Bundle.main.url(forResource: "demo.json", withExtension: nil)
            
            let data = NSData(contentsOf: url!)
            
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let jsonPath = (docDir as NSString).appendingPathComponent("demo.json")
            
            data?.write(toFile: jsonPath, atomically: true)
            
            print(jsonPath)
            
            
            
            
            
        }
    }
}

