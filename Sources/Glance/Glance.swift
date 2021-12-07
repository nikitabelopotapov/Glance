//
//  Glance.swift
//  Glance
//
//  Created by Nikita Belopotapov on 30.04.2021.

import UIKit

enum Configuration {
	static let baseDepth: Float = 0.5
}

public final class Glance {

	/// Main instance of framework
	public static let main = Glance()

	// MARK: Private properties
	private lazy var layoutMapper = LayoutMapper()
	private weak var presentingView: UIView!
	private lazy var dataSource = GlanceDataSource(layoutMapper: layoutMapper)

	private init() {}


	/// Opens visual debugger with provided settings
	/// - Parameters:
	///   - view: view for debugging
	///   - navigation: navigation controller that should display debugging view controller if nil
	public func debug(view: UIView) {
		guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else { return }
		presentingView = view
		let models = dataSource.snapshots(for: presentingView)
		let viewController = GlanceViewController()
		viewController.layoutModels = models
		rootViewController.present(viewController, animated: true, completion: nil)
	}

	/// Adds new layout provider for specified view
	/// - Parameters:
	///   - provider: Provider with custom layout, conforming LayoutProvidable protocol
	///   - viewClass:
	///   - force: Should default provider be overridden
	public func addLayoutProvider(provider: LayoutProvidable, viewClass: UIView.Type, force: Bool = false) {
		if viewClass == UIView.self && force == false {
			assertionFailure("Should not create custom providers for UIView")
		}
		layoutMapper.addCustom(layout: provider, className: "\(viewClass)", force: force)
	}
}
