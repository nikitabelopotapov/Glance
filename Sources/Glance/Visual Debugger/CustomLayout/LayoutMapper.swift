//
//  LayoutMapper.swift
//  Glance
//
//  Created by Nikita Belopotapov on 30.04.2021.
//

import UIKit

public protocol LayoutMappable {
	func addCustom(layout: LayoutProvidable, className: String, force: Bool)
	func layout(for view: UIView) -> LayoutProvidable?
}

final class LayoutMapper: LayoutMappable {
	private lazy var layoutMap: [String: LayoutProvidable] = [
		"UITableView": CollectionLayoutProvider(),
		"UICollectionView": CollectionLayoutProvider(),
		"UITabBar": TabbarLayoutProvider(),
		"UINavigationBar": NavigationBarLayoutProvider()
	]

	func addCustom(layout: LayoutProvidable, className: String, force: Bool) {
		if force {
			layoutMap[className] = layout
		} else {
			guard layoutMap[className] == nil else {
				assertionFailure("Should not override existing providers")
				return
			}

			layoutMap[className] = layout
		}
	}

	func layout(for view: UIView) -> LayoutProvidable? {
		let viewClass = type(of: view)
		let viewClassName = "\(viewClass)"
		var providerMap = layoutMap.first { $0.key.lowercased() == viewClassName.lowercased() }

		if providerMap?.value == nil {
			if let viewSuperClass = viewClass.superclass() {
				let viewSuperClassName = "\(viewSuperClass)"
				providerMap = layoutMap.first { $0.key.lowercased() == viewSuperClassName.lowercased() }
			}
		}
		return providerMap?.value
	}
}
