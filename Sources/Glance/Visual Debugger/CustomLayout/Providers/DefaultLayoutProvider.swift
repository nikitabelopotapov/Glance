//
//  DefaultLayoutProvider.swift
//  Glance
//
//  Created by Nikita Belopotapov on 30.04.2021.
//

import UIKit

final class DefaultLayoutProvider: LayoutProvidable {
	var layoutMapper: LayoutMappable?
	func provide(for view: UIView, depth: inout Float, masterView: UIView?) -> [LayoutSnapshot] {
		var result = [LayoutSnapshot]()
		let screenSize = (UIApplication.shared.windows.first ?? UIWindow()).screenSize
		var frame = view.frame(in: masterView, screenSize: screenSize)
		if frame == .zero { return result }

		var hidden = [UIView: Bool]()
		for v in view.subviews {
			hidden[v] = v.isHidden
			v.isHidden = true
		}

		var snapshot = view.takeSnapshotOfView()

		for v in view.subviews {
			v.isHidden = hidden[v] ?? true
		}

		if let viewFrameInSuperView = view.superview?.convert(view.frame, to: masterView) {
			var xValueToCrop: CGFloat = 0
			var yValueToCrop: CGFloat = 0

			if viewFrameInSuperView.maxX > screenSize.width {
				xValueToCrop = viewFrameInSuperView.width - (viewFrameInSuperView.maxX - screenSize.width)
				frame.size.width = xValueToCrop
				frame.origin.x -= (viewFrameInSuperView.size.width -  xValueToCrop) / 2
			}

			if viewFrameInSuperView.minX < 0 {
				if xValueToCrop > 0 {
					xValueToCrop -= abs(viewFrameInSuperView.minX)
					frame.size.width = xValueToCrop
					frame.origin.x -= (viewFrameInSuperView.width - screenSize.width) / 4
				} else {
					xValueToCrop = viewFrameInSuperView.width - abs(viewFrameInSuperView.minX)
					frame.size.width = xValueToCrop
					frame.origin.x -= (viewFrameInSuperView.width - screenSize.width) / 2
				}
			}

			if viewFrameInSuperView.maxY > screenSize.height {
				yValueToCrop = viewFrameInSuperView.height - (viewFrameInSuperView.maxY - screenSize.height)
				frame.size.height = yValueToCrop
				frame.origin.y += (viewFrameInSuperView.size.height -  yValueToCrop) / 2
			}

			if viewFrameInSuperView.minY < 0 {
				if yValueToCrop > 0 {
					yValueToCrop -= abs(viewFrameInSuperView.minY)
					frame.size.height = yValueToCrop
					frame.origin.y -= (viewFrameInSuperView.height - screenSize.height) / 4
				} else {
					yValueToCrop = viewFrameInSuperView.height - abs(viewFrameInSuperView.minY)
					frame.size.height = yValueToCrop
					frame.origin.y -= (viewFrameInSuperView.height - screenSize.height) / 2
				}
			}


			if xValueToCrop > 0 || yValueToCrop > 0 {
				xValueToCrop = xValueToCrop > 0 ? xValueToCrop : viewFrameInSuperView.size.width
				yValueToCrop = yValueToCrop > 0 ? yValueToCrop : viewFrameInSuperView.size.height

				snapshot = snapshot?.crop(toSize: CGSize(width: xValueToCrop, height: yValueToCrop))
			}
		}

		snapshot = snapshot?.imageByAddingBorder(color: .gray)

		guard let image = snapshot else { return result }
		result.append(LayoutSnapshot(image: image, depth: depth, frame: frame, view: view))
		return result
	}
}
