//
//  UIWindow+Extensions.swift
//  Glance
//
//  Created by Nikita Belopotapov on 30.04.2021.
//

import UIKit

extension UIWindow {
	var screenSize: CGSize {
		return rootViewController?.view.frame.size ?? .zero
	}
}
