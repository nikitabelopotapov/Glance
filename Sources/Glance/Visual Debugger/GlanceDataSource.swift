//
//  GlanceDataSource.swift
//  Glance
//
//  Created by Nikita Belopotapov on 22.05.2021.
//

import UIKit

final class GlanceDataSource {
	private weak var presentingView: UIView?
	private let layoutMapper: LayoutMappable

	init(layoutMapper: LayoutMappable) {
		self.layoutMapper = layoutMapper
	}

	func snapshots(for view: UIView) -> [LayoutSnapshot] {
		presentingView = view
		let result = createSnapshots(for: view)
		return result
	}

	private func createSnapshots(for view: UIView) -> [LayoutSnapshot] {
        var depth: Float = 0
		return getSubviews(view: view, depth: &depth)
	}

	private func getSubviews(view: UIView, depth: inout Float) -> [LayoutSnapshot] {
		var result = [LayoutSnapshot]()
		guard let presentingView = presentingView else { return result }

		if let layout = layoutMapper.layout(for: view) {
			layout.layoutMapper = layoutMapper
			let snapshots = layout.provide(for: view, depth: &depth, masterView: presentingView)
			result.append(contentsOf: snapshots)
			return result
		}

		let layout = DefaultLayoutProvider()
        let some = layout.provide(for: view, depth: &depth, masterView: presentingView)
		result.append(contentsOf: some)

        for (index, sub) in view.subviews.enumerated() {
            var newDepth = depth + Configuration.baseDepth
			let arr = getSubviews(view: sub, depth: &newDepth)
			result.append(contentsOf: arr)
            let nextIndex = index + 1
            if view.subviews.count > nextIndex {
                let nextView = view.subviews[nextIndex]
                if sub.frame.intersects(nextView.frame) {
                    depth = newDepth
                }
            }
		}
		return result
	}
}
