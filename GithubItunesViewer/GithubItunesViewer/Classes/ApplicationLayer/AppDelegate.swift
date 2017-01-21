//
//  AppDelegate.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let assemblyFactory = AssemblyFactoryImplementation()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let initialViewController = assemblyFactory.mainAssembly().module()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

