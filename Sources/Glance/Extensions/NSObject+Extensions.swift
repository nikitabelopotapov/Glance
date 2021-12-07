//
//  NSObject+Extensions.swift
//  Glance
//
//  Created by Nikita Belopotapov on 30.04.2021.
//

import Foundation

extension NSObject {
	func getClasses() -> [String] {
		var result = [String]()
		result.append("\(type(of: self))")
		var condition = true
		var supercl: AnyClass? = self.superclass
		while condition == true {
			if let sup = supercl {
				supercl = sup.superclass()
				result.append("\(sup)")
			} else {
				condition = false
			}
		}
		return result
	}

	var objectAddress: String {
		let opaque: UnsafeMutableRawPointer = Unmanaged.passUnretained(self).toOpaque()
		return String(describing: opaque)
	}

	var className: String {
		return "\(type(of: self))"
	}

	var nameWithAddress: String {
		return "<\(self.className): \(self.objectAddress)>"
	}
}
