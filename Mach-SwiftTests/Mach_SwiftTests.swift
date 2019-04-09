//
//  Mach_SwiftTests.swift
//  Mach-SwiftTests
//
//  Created by Daisuke T on 2019/04/09.
//  Copyright © 2019 Mach-Swift. All rights reserved.
//

import XCTest
@testable import Mach_Swift

class Mach_SwiftTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	
	// MARK: - Mach.Host
	func testMachHostVMStatics() {
		let val = Mach.Host.vmStatics()
		
		XCTAssertFalse(val.freeSize == 0 &&
			val.activeSize == 0 &&
			val.inactiveSize == 0 &&
			val.wireSize == 0)
	}
	
	func testMachHostBasicInfo() {
		let val = Mach.Host.basicInfo()
		
		XCTAssertFalse(val.maxCPUs == 0 &&
			val.availCPUs == 0 &&
			val.memorySize == 0 &&
			val.cpuType == 0 &&
			val.cpuSubType == 0 &&
			val.cpuThreadType == 0 &&
			val.physicalCPU == 0 &&
			val.physicalCPUMax == 0 &&
			val.logicalCPU == 0 &&
			val.logicalCPUMax == 0 &&
			val.maxMem == 0)
	}
	
	func testMachHostCPULoadInfo() {
		let val = Mach.Host.cpuLoadInfo()
		
		XCTAssertFalse(val.userTick == 0 &&
			val.systemTick == 0 &&
			val.idleTick == 0 &&
			val.niceTick == 0)
	}
	
	func testMachHostProcessorInfo() {
		let array = Mach.Host.processorInfo()
		
		XCTAssertNotEqual(array.count, 0)
		
		for elm in array {
			XCTAssertFalse(elm.userTick == 0 &&
				elm.systemTick == 0 &&
				elm.idleTick == 0 &&
				elm.niceTick == 0)
		}
	}
	
	
	// MARK: - Mach.Task
	func testMachTaskBasicInfo() {
		let val = Mach.Task.basicInfo()
		
		XCTAssertFalse(val.virtualSize == 0 &&
			val.residentSize == 0 &&
			val.residentSizeMax == 0)
	}
	
	func testMachTaskThreadBasicInfo() {
		let array = Mach.Task.threadBasicInfo()
		
		XCTAssertNotEqual(array.count, 0)
	}

}
