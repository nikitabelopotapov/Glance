//
//  TestTableViewController.swift
//  GlanceExample
//
//  Created by Nikita Belopotapov on 12.05.2021.
//

import UIKit
import Glance

final class TestTableViewController: UIViewController {
	let tableView = NewTableView()
	let searchBar = UISearchBar()
	let button = UIButton()
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.rowHeight = 150
		tableView.backgroundColor = .red
		searchBar.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .green
		view.addSubview(tableView)
		view.addSubview(button)
        button.backgroundColor = .red
		view.addSubview(searchBar)
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)

		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		tableView.reloadData()

		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Show", for: .normal)
		button.setTitleColor(.black, for: .normal)

		NSLayoutConstraint.activate([
			searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 91.0),
			searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
			button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			button.heightAnchor.constraint(equalToConstant: 50)

		])
	}

	func setupView(view: UIView, color: UIColor) {
		view.backgroundColor = color
		view.clipsToBounds = true
		view.layer.cornerRadius = 10.0
		view.translatesAutoresizingMaskIntoConstraints = false
	}
}

extension TestTableViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1000
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.contentView.backgroundColor = .white
		cell.backgroundColor = .white
		cell.textLabel?.textColor = .black
		cell.textLabel?.text = "\(indexPath.row)"
		return cell
	}
}

final class NewTableView: UITableView {}
