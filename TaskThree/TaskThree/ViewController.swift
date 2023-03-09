//
//  ViewController.swift
//  TaskTwo
//
//  Created by Alexander Nifontov on 08.03.2023.
//

import UIKit

class ViewController: UIViewController {
	
	// MARK: - Subviews
	
	private lazy var squareView = UIView()
	private lazy var slider = UISlider()
	
	// MARK: - Properties
	
	private let animator = UIViewPropertyAnimator(duration: 0.6, curve: .easeInOut)
	
	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
		setupConstraints()
	}

	// MARK: - Methods
	
	private func setupUI() {
		squareView.translatesAutoresizingMaskIntoConstraints = false
		squareView.backgroundColor = .systemOrange
		squareView.layer.cornerRadius = 20
		
		slider.translatesAutoresizingMaskIntoConstraints = false
		slider.addTarget(self, action: #selector(slider_valueChanged), for: .valueChanged)
		slider.addTarget(self, action: #selector(slider_touchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
		
		animator.pausesOnCompletion = true
		
		animator.addAnimations {
			let rightMargin = self.view.layoutMargins.right
			let screenWidth = self.view.bounds.width
			let squareWidth = (self.squareView.bounds.width * 1.5) / 2
			let newCenter = screenWidth - rightMargin - squareWidth
			
			var transform: CGAffineTransform = .identity
			transform = transform.rotated(by: .pi / 2)
			transform = transform.scaledBy(x: 1.5, y: 1.5)
			
			self.squareView.transform = transform
			self.squareView.center.x = newCenter
			print(newCenter)
		}
	}
	
	private func setupConstraints() {
		view.addSubview(squareView)
		view.addSubview(slider)
		
		let constraints = [
			squareView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
			squareView.leadingAnchor.constraint(greaterThanOrEqualTo: view.layoutMarginsGuide.leadingAnchor),
			squareView.heightAnchor.constraint(equalTo: squareView.widthAnchor),
			squareView.heightAnchor.constraint(equalToConstant: 100),
			
			slider.topAnchor.constraint(equalTo: squareView.bottomAnchor, constant: 40),
			slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
			slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
		]
		
		constraints.forEach { $0.isActive = true }
	}
	
	// MARK: - Actions
	
	@objc
	private func slider_touchUp(_ sender: UISlider, forEvent event: UIEvent) {
		animator.startAnimation()
		sender.setValue(sender.maximumValue, animated: true)
	}
	
	@objc
	private func slider_valueChanged(_ sender: UISlider) {
//		animator.pauseAnimation()
		animator.fractionComplete = CGFloat(sender.value)
	}
}

