//
//  CustomProfilerValues.swift
//  Glance
//
//  Created by Nikita Belopotapov on 11.05.2021.
//

import UIKit

protocol CustomProfilerValues where Self: UIView {
	func values() -> [AnyKeyPath]
}
