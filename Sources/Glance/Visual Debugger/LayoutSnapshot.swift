//
//  LayoutSnapshot.swift
//  Glance
//
//  Created by Nikita Belopotapov on 30.04.2021.
//

import UIKit

public struct LayoutSnapshot {
	let image: UIImage
	let depth: Float
	let frame: CGRect
	var view: UIView
}

extension LayoutSnapshot: CustomDebugStringConvertible {
	public var debugDescription: String {
		return "image: \(image) \n depth: \(depth) \n frame: \(frame) \n  view: \(view)"
	}
}

extension UIView {
	var viewFrameinSuperview: CGRect {
		return superview?.convert(frame, to: UIApplication.shared.windows.first) ?? .zero
	}
}
