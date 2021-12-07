//
//  CollectionLayoutProvider.swift
//  Glance
//
//  Created by Nikita Belopotapov on 30.04.2021.
//

import UIKit

final class CollectionLayoutProvider: LayoutProvidable {
	var layoutMapper: LayoutMappable?

	func provide(for view: UIView, depth: inout Float, masterView: UIView?) -> [LayoutSnapshot] {
		var result = [LayoutSnapshot]()
		result.append(contentsOf: layout(main: view, depth: &depth, masterView: masterView))
		return result
	}

	func layout(main view: UIView, depth: inout Float, masterView: UIView?) -> [LayoutSnapshot] {
		let defaultProvider = DefaultLayoutProvider()
		var result = [LayoutSnapshot]()
        var maxDepth: Float = 0

		result.append(contentsOf: defaultProvider.provide(for: view, depth: &depth, masterView: masterView))
		for (index, sub) in view.subviews.enumerated() {
			var newDepth = index % 2 == 0 ? depth + Configuration.baseDepth : depth + Configuration.baseDepth / 2
			result.append(contentsOf: layoutSubviews(for: sub, depth: &newDepth, masterView: masterView))
            if newDepth > maxDepth {
                maxDepth = newDepth
            }
		}
        depth = maxDepth
        
		return result
	}

	func layoutSubviews(for view: UIView, depth: inout Float, masterView: UIView?) -> [LayoutSnapshot] {
		var result = [LayoutSnapshot]()

		if let layout = layoutMapper?.layout(for: view) {
			let snapshots = layout.provide(for: view, depth: &depth, masterView: masterView)
			result.append(contentsOf: snapshots)
			return result
		}
		let defaultLayout = DefaultLayoutProvider()
        
        let items = defaultLayout.provide(for: view, depth: &depth, masterView: masterView)
        
        if items.isEmpty {
            return result
        }
        
		result.append(contentsOf: items)
		for (index, subview) in view.subviews.enumerated() {
            var newDepth: Float = depth + Configuration.baseDepth
            result.append(contentsOf: layoutSubviews(for: subview, depth: &newDepth, masterView: masterView))
            let nextIndex = index + 1
            if view.subviews.count > nextIndex {
                let nextView = view.subviews[nextIndex]
                if subview.frame.intersects(nextView.frame) {
                    depth = newDepth
                }
            }
		}
		return result
	}
}
