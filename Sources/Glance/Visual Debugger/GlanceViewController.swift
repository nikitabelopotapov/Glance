//
//  GlanceViewController.swift
//  Glance
//
//  Created by Nikita Belopotapov on 30.04.2021.
//

import UIKit
import SceneKit

final class GlanceViewController: UIViewController {
	struct Constants {
		static let decreaseСoefficient: CGFloat = 50.0
		static let defaultCameraPosition: SCNVector3 = SCNVector3(x: 0, y: 0, z: 40)
	}
	var layoutModels = [LayoutSnapshot]() {
		didSet {
			addedNodes.forEach({ $0.removeFromParentNode() })
			addedNodes.removeAll()
		}
	}
	private let sceneView = SCNView()
	private let closeButton = UIButton()
	private let scene = SCNScene()
	private let cameraNode = SCNNode()
	private var addedNodes = [SCNNode]()
	var selectedView: UIView?
	var selectedNode: SCNNode?

	override func viewDidLoad() {
        view.backgroundColor = .white
		sceneView.backgroundColor = .white
		setupSceneView()

		sceneView.scene = scene
		setupCameraNode()
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(tap:)))
		sceneView.addGestureRecognizer(tapGesture)

		closeButton.translatesAutoresizingMaskIntoConstraints = false
		closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
		closeButton.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
		view.addSubview(closeButton)

		NSLayoutConstraint.activate([
			closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
			closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 24.0),
			closeButton.heightAnchor.constraint(equalToConstant: 40),
			closeButton.widthAnchor.constraint(equalToConstant: 80),
		])
	}

	@objc func closeViewController() {
		dismiss(animated: true, completion: nil)
	}

	@objc func depthSliderUpdated(slider: UISlider) {
		updateZIndex(depth: slider.value)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		prepareLayoutData()
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		cameraNode.position = Constants.defaultCameraPosition
	}

	func updateZIndex(depth: Float) {}

	@objc private func didTapView(tap: UIGestureRecognizer) {
		if tap.state == .ended {
			let location: CGPoint = tap.location(in: sceneView)
			let hits = sceneView.hitTest(location, options: nil)
			if !hits.isEmpty {
				guard let tappedNode = hits.first?.node else { return }
				guard let address = tappedNode.accessibilityLabel else { return }
				let snapshot = layoutModels.first(where: { "\(Unmanaged.passUnretained($0.view).toOpaque())" == address })
				guard let s = snapshot else { return }
				selectedView = s.view
				print(s)
				selectedNode?.geometry?.firstMaterial?.emission.contents = s.image
				selectedNode = tappedNode

				SCNTransaction.begin()
				SCNTransaction.animationDuration = 0.0

				tappedNode.geometry?.firstMaterial?.emission.contents = UIColor.red

				SCNTransaction.commit()

				let provider = ProfilerDataProvider()
				let profill = ProfilerViewController(model: provider.model(for: s.view))
				self.present(profill, animated: true, completion: nil)
			}
		}
	}
}

private extension GlanceViewController {
	func setupSceneView() {
		view.addSubview(sceneView)
		sceneView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
		sceneView.allowsCameraControl = true
	}

	func setupCameraNode() {
		cameraNode.camera = SCNCamera()
		cameraNode.position = Constants.defaultCameraPosition
		scene.rootNode.addChildNode(cameraNode)
	}
}

private extension GlanceViewController {
	func prepareLayoutData() {
		for model in layoutModels {
			let position = SCNVector3(
				x: Float(model.frame.origin.x / Constants.decreaseСoefficient),
				y: Float(model.frame.origin.y / Constants.decreaseСoefficient),
				z: model.depth
			)

			placeImage(model: model, position: position)
		}
	}

	func placeImage(model: LayoutSnapshot, position: SCNVector3) {
		let geometry = SCNPlane(width: model.frame.size.width / Constants.decreaseСoefficient,
								height: model.frame.size.height / Constants.decreaseСoefficient)
		let material = SCNMaterial()
		material.isDoubleSided = true
		material.diffuse.contents = model.image
		geometry.materials = [material]
		let geometryNode = SCNNode(geometry: geometry)
		geometryNode.position = position
		geometryNode.accessibilityLabel = "\(Unmanaged.passUnretained(model.view).toOpaque())"
		addedNodes.append(geometryNode)
		scene.rootNode.addChildNode(geometryNode)
	}
}
