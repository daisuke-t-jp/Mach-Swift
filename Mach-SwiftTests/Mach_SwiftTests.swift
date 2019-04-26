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
  
  
  // MARK: - Mach.Host.Statistics
  func testMachHostStatistics() {
    let val = Mach.Host.Statistics.vmInfo()
    
    XCTAssertFalse(val.freeSize == 0 &&
      val.activeSize == 0 &&
      val.inactiveSize == 0 &&
      val.wireSize == 0)
  }
  
  func testMachHostStatisticsCPULoadInfo() {
    let val = Mach.Host.Statistics.cpuLoadInfo()
    
    XCTAssertFalse(val.userTick == 0 &&
      val.systemTick == 0 &&
      val.idleTick == 0 &&
      val.niceTick == 0)
  }
  
  
  // MARK: - Mach.Host.Info
  func testMachHostInfoBasicInfo() {
    let val = Mach.Host.Info.basicInfo()
    
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
  
  
  // MARK: - Mach.Host.Processor
  func testMachHostProcessorInfo() {
    let array = Mach.Host.Processor.cpuLoadInfoArray()
    
    XCTAssertNotEqual(array.count, 0)
    
    for elm in array {
      XCTAssertFalse(elm.userTick == 0 &&
        elm.systemTick == 0 &&
        elm.idleTick == 0 &&
        elm.niceTick == 0)
    }
  }
  
  
  // MARK: - Mach.Task.Info
  func testMachTaskInfoBasicInfo() {
    let val = Mach.Task.Info.basicInfo()
    
    XCTAssertFalse(val.virtualSize == 0 &&
      val.residentSize == 0 &&
      val.residentSizeMax == 0)
  }
  
  
  // MARK: - Mach.Task.Thread
  func testMachTaskThreadBasicInfo() {
    let array = Mach.Task.Thread.basicInfoArray()
    
    XCTAssertNotEqual(array.count, 0)
  }
  
}
