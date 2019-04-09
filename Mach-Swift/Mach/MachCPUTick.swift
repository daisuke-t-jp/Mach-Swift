//
//  MachCPUTick.swift
//  Mach-Swift
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 Mach-Swift. All rights reserved.
//

import Foundation

extension Mach {

	struct CPUTick {
		let userTick: UInt32
		let systemTick: UInt32
		let idleTick: UInt32
		let niceTick: UInt32
	}
	
}

extension Mach.CPUTick {

	init() {
		userTick = 0
		systemTick = 0
		idleTick = 0
		niceTick = 0
	}

}
