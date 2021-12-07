//
//  TestCollectionViewController.swift
//  GlanceExample
//
//  Created by Nikita Belopotapov on 24.05.2021.
//

import UIKit

final class TestCollectionViewController: UIViewController {
	private lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let itemSize = view.frame.size.height / 4
		layout.itemSize = CGSize(width: itemSize, height: itemSize)
		layout.scrollDirection = .horizontal
		let collectionView = UICollectionView(frame: .zero,
											  collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(TestColelctionViewCell.self, forCellWithReuseIdentifier: "Cell")

		return collectionView
	}()

	override func viewDidLoad() {
		view.backgroundColor = .white
		view.addSubview(collectionView)
		collectionView.dataSource = self

		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
}

extension TestCollectionViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 20
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? TestColelctionViewCell else {
			return UICollectionViewCell()
		}
		cell.backgroundColor = .randomColor
		cell.textLabel.text = "\(indexPath.row)"
		return cell
	}
}

fileprivate extension UIColor {
	static var randomColor: UIColor {
		return UIColor(red: CGFloat.random(in: 1...255)/255,
					   green: CGFloat.random(in: 1...255)/255,
					   blue: CGFloat.random(in: 1...255)/255,
					   alpha: 1.0)
	}
}



final class TestColelctionViewCell: UICollectionViewCell {

	let textLabel = UILabel()
	override init(frame: CGRect) {
		super.init(frame: .zero)

		textLabel.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(textLabel)

		NSLayoutConstraint.activate([
			textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
		])
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
