//
//  NavigationBarLayoutProvider.swift
//  Glance
//
//  Created by Nikita Belopotapov on 30.04.2021.
//

import UIKit

final class NavigationBarLayoutProvider: LayoutProvidable {
	var layoutMapper: LayoutMappable?
	func provide(for view: UIView, depth: inout Float, masterView: UIView?) -> [LayoutSnapshot] {
		var result = [LayoutSnapshot]()
		var newDepth = depth + Configuration.baseDepth * 4
		result.append(contentsOf: layoutSubviews(for: view, depth: &newDepth, masterView: masterView))
		return result
	}

	func layoutSubviews(for view: UIView, depth: inout Float, masterView: UIView?) -> [LayoutSnapshot] {
		var result = [LayoutSnapshot]()
		let defaultLayout = DefaultLayoutProvider()
        result.append(contentsOf: defaultLayout.provide(for: view, depth: &depth, masterView: masterView))
		for subview in view.subviews {
			depth += Configuration.baseDepth
			result.append(contentsOf: layoutSubviews(for: subview, depth: &depth, masterView: masterView))
		}
		return result
	}
}
