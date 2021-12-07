//
//  ProfilerDataProvider.swift
//  Glance
//
//  Created by Nikita Belopotapov on 11.05.2021.
//

import UIKit

final class ProfilerDataProvider {

	func model(for view: UIView) -> ProfilerModel {
		let allClasses = view.getClasses()

		var sections = [ProfilerModel.Section]()
		for className in allClasses.reversed() {
			if let section = section(for: className, object: view) {
				sections.append(section)
			}
		}

		return ProfilerModel(sections: sections)
	}

	func section(for className: String, object: NSObject) -> Section? {
		let sectionRecords = records(for: className, object: object)
		if sectionRecords.isEmpty { return nil }
		return Section(title: "\(className)", records: sectionRecords)
	}

	func records(for className: String, object: NSObject) -> [Record] {
		var result = [Record]()
		if className == "\(UIView.self)" && object is UIView {
			let view = object as! UIView
			result.append(contentsOf: records(for: "\(CALayer.self)", object: view.layer))
		}
		guard let values = values(for: className) else { return result }
		for value in values {
			let recordValue = object[keyPath: value.value]
			if let newValue = recordValue {
				let record = Record(title: value.key, value: "\(newValue)")
				result.append(record)
			}
		}

		return result
	}
}

private extension ProfilerDataProvider {

	func values(for className: String) -> [String: AnyKeyPath]? {
		switch className {
		case "\(UIView.self)":
			return DefaultProfilerValues.viewValues
		case "\(UITableView.self)":
			return DefaultProfilerValues.tableViewValues
		case "\(UITableViewCell.self)":
			return DefaultProfilerValues.tableViewCellValues
		case "\(NSObject.self)":
			return DefaultProfilerValues.objectValues
		case "\(CALayer.self)":
			return DefaultProfilerValues.layerValues
		case "\(UIWindow.self)":
			return DefaultProfilerValues.windowValues
		case "\(UIScrollView.self)":
			return DefaultProfilerValues.scrollViewValues
		case "\(UIControl.self)":
			return DefaultProfilerValues.controlValues
		case "\(UILabel.self)":
			return DefaultProfilerValues.labelValues
		default:
			return nil
		}
	}
}



extension String.StringInterpolation {
	public mutating func appendInterpolation(_ value: UIView.ContentMode) {
		appendLiteral("")
	}
}
