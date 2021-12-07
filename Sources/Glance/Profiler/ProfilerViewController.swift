//
//  ProfilerViewController.swift
//  Glance
//
//  Created by Nikita Belopotapov on 03.05.2021.
//

import UIKit

class ProfilerViewController: UIViewController {
	private let tableView: UITableView = UITableView()
	private var model: ProfilerModel

	init(model: ProfilerModel) {
		self.model = model
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(tableView)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.reloadData()
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])

		tableView.reloadData()
	}
}

extension ProfilerViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return model.sections.count
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return model.sections[section].records.count
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return model.sections[section].title
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		let cellModel = model.sections[indexPath.section].records[indexPath.row]
		cell.textLabel?.numberOfLines = 0
		cell.textLabel?.text = "\(cellModel.title) \(cellModel.value)"
		return cell
	}
}

extension ProfilerViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
		return true
	}

	func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
		if action.description == "copy:" {
			let cell = tableView.cellForRow(at: indexPath)
			if let text = cell?.textLabel?.text?.components(separatedBy: ":").last {
				UIPasteboard.general.string = text
			}
		}
	}

	func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
		return true
	}
}
