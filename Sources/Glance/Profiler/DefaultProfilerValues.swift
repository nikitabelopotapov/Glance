//
//  DefaultProfilerValues.swift
//  Glance
//
//  Created by Nikita Belopotapov on 25.05.2021.
//

import UIKit

extension UITableViewCell {
	var text: String? {
		return textLabel?.text
	}
}

enum DefaultProfilerValues {

	static var tableViewValues: [String: AnyKeyPath] {
		return [
			"Sections": \UITableView.numberOfSections,
			"Style": \UITableView.style,
			"Separator": \UITableView.separatorStyle,
			"Separator Color": \UITableView.separatorColor,
			"Data Source": \UITableView.dataSource,
			"Delegate": \UITableView.delegate,
			"Separator Inset": \UITableView.separatorInset,
			"Selection": \UITableView.allowsSelection,
			"Edit Selection": \UITableView.allowsSelectionDuringEditing,
			"Row Height": \UITableView.rowHeight,
			"Section Header": \UITableView.sectionHeaderHeight,
			"Section Footer": \UITableView.sectionFooterHeight,

		]
	}

	static var scrollViewValues: [String: AnyKeyPath] {
		return [
			"Indicators Horizontal": \UIScrollView.showsHorizontalScrollIndicator,
			"Indicators Vertical": \UIScrollView.showsVerticalScrollIndicator,
			"Scrolling enabled": \UIScrollView.isScrollEnabled,
			"Paging enabled": \UIScrollView.isPagingEnabled,
			"Direction Lock enabled": \UIScrollView.isDirectionalLockEnabled,
			"Bounces": \UIScrollView.bounces,
			"Bounces Horizontally": \UIScrollView.alwaysBounceHorizontal,
			"Bounces Vertically": \UIScrollView.alwaysBounceVertical,
			"Zoom min": \UIScrollView.minimumZoomScale,
			"Zoom max": \UIScrollView.maximumZoomScale,
			"Touch Zoom Bounces": \UIScrollView.bouncesZoom,
			"Touch Delays": \UIScrollView.delaysContentTouches,
			"Touch Cancellable Content": \UIScrollView.canCancelContentTouches,
			"Keyboard": \UIScrollView.keyboardDismissMode,
		]
	}

	static var objectValues: [String: AnyKeyPath] {
		return [
			"Class name": \NSObject.className,
			"Address": \NSObject.objectAddress
		]
	}

	static var tableViewCellValues: [String: AnyKeyPath] {
		return [
			"Image": \UITableViewCell.imageView?.image,
			"Identifier": \UITableViewCell.reuseIdentifier,
			"Selection": \UITableViewCell.selectionStyle,
			"Accessory": \UITableViewCell.accessoryView,
			"Editing": \UITableViewCell.editingStyle,
			"Text": \UITableViewCell.text
		]
	}

	static var viewValues: [String: AnyKeyPath] {
		return [
			"Content Mode": \UIView.contentMode,
			"Tag": \UIView.tag,
			"User Interaction Enabled": \UIView.isUserInteractionEnabled,
			"Multiple Touch": \UIView.isMultipleTouchEnabled,
			"Frame": \UIView.frame,
			"Color": \UIView.backgroundColor,
			"View frame in superview": \UIView.viewFrameinSuperview
		]
	}

	static var layerValues: [String: AnyKeyPath] {
		return [
			"Layer": \CALayer.nameWithAddress,
			"Layer Class": \CALayer.className,
		]
	}

	static var windowValues: [String: AnyKeyPath] {
		return [
			"Key Window": \UIWindow.isKeyWindow,
			"Window Level": \UIWindow.windowLevel,
			"Root View Controller": \UIWindow.rootViewController
		]
	}

	static var controlValues: [String: AnyKeyPath] {
		return [
			"Content selected": \UIControl.isSelected,
			"Content enabled": \UIControl.isEnabled,
			"Content highlighted": \UIControl.isHighlighted,
		]
	}

	static var labelValues: [String: AnyKeyPath] {
		return [
			"Text": \UILabel.text,
			"Text Color": \UILabel.textColor,
			"Font": \UILabel.font,
			"Alignment": \UILabel.textAlignment,
			"Lines": \UILabel.numberOfLines,
			"Enabled": \UILabel.isEnabled,
			"Highlighted": \UILabel.isHighlighted,
			"Baseline": \UILabel.baselineAdjustment,
			"Line break": \UILabel.lineBreakMode
		]
	}
}
