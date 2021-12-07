//
//  LayoutProvidable.swift
//  Glance
//
//  Created by Nikita Belopotapov on 30.04.2021.
//

import UIKit

public protocol LayoutProvidable: AnyObject {
	var layoutMapper: LayoutMappable? { get set }
	func provide(for view: UIView, depth: inout Float, masterView: UIView?) -> [LayoutSnapshot]
}
