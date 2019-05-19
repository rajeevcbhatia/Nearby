//
//  AppDelegate.swift
//  Nearby
//
//  Created by Rajeev Bhatia on 15/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        let vc = MapViewController(service: ProcessInfo.processInfo.currentService)
        window?.rootViewController = vc

        return true
    }
}

private extension ProcessInfo {
    
    var currentService: Service {
        if arguments.contains("testHappyFlow") {
            return MockSuccessService.shared
        } else if arguments.contains("testErrorFlow") {
            return MockErrorService.shared
        } else {
            return NetworkService.shared
        }
    }
    
}
