//
//  AppDelegate.swift
//  GlanceExample
//
//  Created by Nikita Belopotapov on 12.05.2021.
//

import UIKit
import Glance

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		return true
	}

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}
}

extension UIWindow {
	open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		super.motionEnded(motion, with: event)
		if motion == .motionShake {
            guard let window = UIApplication.shared.windows.first else { return }
            Glance.main.debug(view: window)
		}
	}
}
