//
//  TabbarLayoutProvider.swift
//  Glance
//
//  Created by Nikita Belopotapov on 24.05.2021.
//

import UIKit

final class TabbarLayoutProvider: LayoutProvidable {
	var layoutMapper: LayoutMappable?
	func provide(for view: UIView, depth: inout Float, masterView: UIView?) -> [LayoutSnapshot] {
		var result = [LayoutSnapshot]()
		result.append(contentsOf: layout(main: view, depth: depth + 5, masterView: masterView))
		return result
	}

	func layout(main view: UIView, depth: Float, masterView: UIView?) -> [LayoutSnapshot] {
		var result = [LayoutSnapshot]()
		let defaultLayout = DefaultLayoutProvider()
        var newDepth = depth
		result.append(contentsOf: defaultLayout.provide(for: view, depth: &newDepth, masterView: masterView))
		var depthsArray = [Float]()
		for (index, subview) in view.subviews.enumerated() {
			var subviewDepth = depth + Configuration.baseDepth
			if index == 0 {
				result.append(contentsOf: layoutSubviews(for: subview, depth: &subviewDepth, masterView: masterView))
				depthsArray.append(subviewDepth)
			} else {
				var someNewIndex = depth
				for (internalIndex, internalSubview) in view.subviews.enumerated() {
					if internalSubview == subview {
						continue
					}
					if subview.frame.intersects(internalSubview.frame) {
						if depthsArray.indices.contains(internalIndex) {
							someNewIndex = depthsArray[internalIndex]
						}
					}
				}
				result.append(contentsOf: layoutSubviews(for: subview, depth: &someNewIndex, masterView: masterView))
				depthsArray.append(someNewIndex)
			}
		}
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
