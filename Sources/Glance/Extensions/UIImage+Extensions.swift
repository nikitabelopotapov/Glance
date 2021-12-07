//
//  UIImage+extensions.swift
//  Glance
//
//  Created by Nikita Belopotapov on 30.04.2021.
//

import UIKit

extension UIImage {
	func imageByAddingBorder(width: CGFloat = 1.01, color: UIColor) -> UIImage? {
		UIGraphicsBeginImageContext(self.size)
		let imageRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
		self.draw(in: imageRect)

		let context = UIGraphicsGetCurrentContext()
		let borderRect = imageRect.insetBy(dx: width / 2, dy: width / 2)

		context?.setStrokeColor(color.cgColor)
		context?.setLineWidth(width)
		context?.stroke(borderRect)

		let borderedImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return borderedImage
	}
}

extension UIImage {

	func crop(toSize: CGSize, fromPoint: CGPoint = .zero ) -> UIImage {

		guard let cgimage = self.cgImage else { return self }

		let contextImage: UIImage = UIImage(cgImage: cgimage)

		guard let newCgImage = contextImage.cgImage else { return self }

		let contextSize: CGSize = contextImage.size

		var posX: CGFloat = 0.0
		var posY: CGFloat = 0.0
		let cropAspect: CGFloat = toSize.width / toSize.height

		var cropWidth: CGFloat = toSize.width
		var cropHeight: CGFloat = toSize.height

		if toSize.width > toSize.height { //Landscape
			cropWidth = contextSize.width
			cropHeight = contextSize.width / cropAspect
			posY = (contextSize.height - cropHeight) / 2
		} else if toSize.width < toSize.height { //Portrait
			cropHeight = contextSize.height
			cropWidth = contextSize.height * cropAspect
			posX = (contextSize.width - cropWidth) / 2
		} else { //Square
			if contextSize.width >= contextSize.height { //Square on landscape (or square)
				cropHeight = contextSize.height
				cropWidth = contextSize.height * cropAspect
				posX = (contextSize.width - cropWidth) / 2
			}else{ //Square on portrait
				cropWidth = contextSize.width
				cropHeight = contextSize.width / cropAspect
				posY = (contextSize.height - cropHeight) / 2
			}
		}

		let rect: CGRect = CGRect(x: posX, y: posY, width: cropWidth, height: cropHeight)
		guard let imageRef: CGImage = newCgImage.cropping(to: rect) else { return self }
		let cropped: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)

		UIGraphicsBeginImageContextWithOptions(toSize, false, self.scale)
		cropped.draw(in: CGRect(x: 0, y: 0, width: toSize.width, height: toSize.height))
		let resized = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		return resized ?? self
	}
}
