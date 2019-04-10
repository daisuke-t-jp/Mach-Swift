//
//  ViewController.swift
//  Mach-SwiftDemo-macOS
//
//  Created by Daisuke T on 2019/04/10.
//  Copyright © 2019 Mach-SwiftDemo-macOS. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		Common.machTest()
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}


}

