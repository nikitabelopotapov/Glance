//
//  SceneDelegate.swift
//  GlanceExample
//
//  Created by Nikita Belopotapov on 12.05.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = scene as? UIWindowScene else { return }
		let window = UIWindow(windowScene: windowScene)

		let tableViewController = TestTableViewController()
		let navigationTableView = UINavigationController(rootViewController: tableViewController)
		navigationTableView.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)

		let collectionViewController = TestCollectionViewController()
		let navigationCollectionView = UINavigationController(rootViewController: collectionViewController)

		navigationCollectionView.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)

		let tabbarController = UITabBarController()
		tabbarController.setViewControllers([navigationTableView, navigationCollectionView], animated: false)

		window.rootViewController = tabbarController
		window.makeKeyAndVisible()
		self.window = window
	}
}

