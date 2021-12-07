//
//  UIView+Extensions.swift
//  Glance
//
//  Created by Nikita Belopotapov on 30.04.2021.
//

import UIKit

extension UIView {
	func takeSnapshotOfView() -> UIImage? {
		var resultImage: UIImage?
		if backgroundColor == nil, !subviews.isEmpty {
			let render = UIGraphicsImageRenderer(size: frame.size)
			let img = render.image { ctx in
				let rectangle = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
				let color = UIColor.clear
				ctx.cgContext.setFillColor(color.cgColor)
				ctx.cgContext.setStrokeColor(color.cgColor)
				ctx.cgContext.setLineWidth(10)
				ctx.cgContext.addRect(rectangle)
				ctx.cgContext.drawPath(using: .fillStroke)
			}
			resultImage = img
		} else {
			let size = CGSize(width: frame.size.width, height: frame.size.height)
			let rect = CGRect(origin: .init(x: 0, y: 0), size: frame.size)

			UIGraphicsBeginImageContext(size)
			drawHierarchy(in: rect, afterScreenUpdates: true)

			resultImage = UIGraphicsGetImageFromCurrentImageContext()
		}

		return resultImage
	}

	func frame(in mainView: UIView?, screenSize: CGSize) -> CGRect {
		if isHidden { return .zero }
		if superview == nil { return frame }
		if let sup = superview {
            if let scrollView = sup as? UIScrollView {
                let yDiff = scrollView.contentOffset.y - abs(frame.origin.y)
                if yDiff > 0 {
                    if yDiff > frame.size.height {
                        return .zero
                    }
                }
                let xDiff = scrollView.contentOffset.x - abs(frame.origin.x)
                if xDiff > 0 {
                    if xDiff > frame.size.width {
                        return .zero
                    }
                }
            } else if sup.clipsToBounds == true {
				if (sup.frame.size.height - abs(frame.origin.y)) <= 0 { return .zero }
				if (sup.frame.size.width - abs(frame.origin.x)) <= 0 { return .zero }
			}
		}
		guard let msView = mainView else { return .zero }
		guard let viewFrameInSuperView = superview?.convert(frame, to: msView) else { return .zero }

		if (viewFrameInSuperView.origin.x >= msView.frame.size.width) || viewFrameInSuperView.origin.y >= msView.frame.size.height {
			return .zero
		}

		if viewFrameInSuperView.origin == .zero && viewFrameInSuperView.size == screenSize {
			return frame
		}
		let oldX = viewFrameInSuperView.origin.x + viewFrameInSuperView.size.width / 2
		let oldY = viewFrameInSuperView.origin.y + viewFrameInSuperView.size.height / 2

		let newX = oldX - screenSize.width / 2
		let newY = screenSize.height / 2 - oldY

		return CGRect(
			x: newX,
			y: newY,
			width: viewFrameInSuperView.size.width,
			height: viewFrameInSuperView.size.height
		)
	}

	func hideSubviews(hide: Bool) {
		for subview in subviews {
			subview.isHidden = hide
		}
	}

}
