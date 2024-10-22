//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	
	@IBOutlet weak var progressBar: UIProgressView!
	@IBOutlet weak var titleLabel: UILabel!
	
	let eggTimes = [
		"Soft": 5,
		"Medium": 7,
		"Hard": 12
	]
	var timer: Timer?
	var secondRemaining: Int = 0
	var hardness: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		progressBar.progress = 0
		
	}
	
	
	@IBAction func hardnessSelected(_ sender: UIButton) {
		hardness = sender.currentTitle ?? "Soft"
		resetProgressBar()
		
		secondRemaining = 0
		titleLabel.text = "Boiling..."
		triggerCountdownTimer(hardness!)
	}
	
	func triggerCountdownTimer(_ hardness: String) {
		timer?.invalidate()

		timer = Timer.scheduledTimer(
			timeInterval: 1.0,
			target: self,
			selector: #selector(updateCountdownTimer),
			userInfo: nil,
			repeats: true)
	}
	
	@objc func updateCountdownTimer() {
		
		print(secondRemaining)
		secondRemaining += 1
		updateProgressBar(hardnessType: hardness!)
		
		if secondRemaining >= eggTimes[hardness!]! {
			timer?.invalidate()
			timer = nil
			titleLabel.text = "Done!"
		}
	}
	
	func resetProgressBar () {
		progressBar.progress = 0
		titleLabel.text = "How do you like your eggs?"
	}
	
	func updateProgressBar (hardnessType: String) {
		progressBar.progress = Float(secondRemaining) / Float(eggTimes[hardnessType]!)
	}
}
