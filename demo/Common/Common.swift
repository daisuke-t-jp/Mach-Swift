//
//  Common.swift
//  Mach-SwiftDemo
//
//  Created by Daisuke T on 2019/04/10.
//  Copyright © 2019 Mach-SwiftDemo. All rights reserved.
//

import Foundation
import Mach_Swift

public class Common {
  public static func machTest() {
    do {
      print("# Mach")
      
      print("## Host")
      print("### Statistics")
      print("#### VMInfo")
      let vm = Mach.Host.Statistics.vmInfo()
      print("- freeSize: \(vm.freeSize)")			// byte size of free
      print("- activeSize: \(vm.activeSize)")		// byte size of active
      print("- inactiveSize: \(vm.inactiveSize)")	// byte size of inactive
      print("- wireSize: \(vm.wireSize)")			// byte size of wire
      print("")
      
      print("#### CPULoadInfo")
      let cpuLoadInfo = Mach.Host.Statistics.cpuLoadInfo()
      print("- userTick: \(cpuLoadInfo.userTick)")
      print("- systemTick: \(cpuLoadInfo.systemTick)")
      print("- idleTick: \(cpuLoadInfo.idleTick)")
      print("- niceTick: \(cpuLoadInfo.niceTick)")
      print("")
      
      print("### Info")
      print("#### BasicInfo")
      let basicInfo = Mach.Host.Info.basicInfo()
      print("- maxCPUs: \(basicInfo.maxCPUs)")
      print("- availCPUs: \(basicInfo.availCPUs)")
      print("- memorySize: \(basicInfo.memorySize)")	// byte size
      print("- cpuType: \(basicInfo.cpuType)")
      print("- cpuSubType: \(basicInfo.cpuSubType)")
      print("- cpuThreadType: \(basicInfo.cpuThreadType)")
      print("- physicalCPU: \(basicInfo.physicalCPU)")
      print("- physicalCPUMax: \(basicInfo.physicalCPUMax)")
      print("- logicalCPU: \(basicInfo.logicalCPU)")
      print("- logicalCPUMax: \(basicInfo.logicalCPUMax)")
      print("- maxMem: \(basicInfo.maxMem)")	// byte size
      print("")
      
      print("### Processor")
      print("#### CPULoadInfo")
      let array = Mach.Host.Processor.cpuLoadInfoArray()
      for i in 0..<array.count {
        let cpu = array[i]
        print("- Core No.\(i)")
        print("    - userTick: \(cpu.userTick)")
        print("    - systemTick: \(cpu.systemTick)")
        print("    - idleTick: \(cpu.idleTick)")
        print("    - niceTick: \(cpu.niceTick)")
        print("")
      }
    }
    
    print("")
    
    
    do {
      print("## Task")
      print("### Info")
      print("#### BasicInfo")
      let basicInfo = Mach.Task.Info.basicInfo()
      print("- virtualSize: \(basicInfo.virtualSize)")
      print("- residentSize: \(basicInfo.residentSize)")
      print("- residentSizeMax: \(basicInfo.residentSizeMax)")
      print("- userTime: \(basicInfo.userTime)")
      print("- systemTime: \(basicInfo.systemTime)")
      print("- policy: \(basicInfo.policy)")
      print("- suspendCount: \(basicInfo.suspendCount)")
      print("")
      
      print("#### ThreadBasicInfo")
      let array = Mach.Task.Thread.basicInfoArray()
      for i in 0..<array.count {
        let thread = array[i]
        print("- Thread No.\(i)")
        print(String.init(format:"    - userTime: %.2f", thread.userTime))
        print(String.init(format:"    - systemTime: %.2f", thread.systemTime))
        print("    - cpuUsage: \(thread.cpuUsage)")
        print("    - policy: \(thread.policy)")
        print("    - runState: \(thread.runState)")
        print("    - flags: \(thread.flags)")
        print("    - suspendCount: \(thread.suspendCount)")
        print("    - sleepTime: \(thread.sleepTime)")
        print(String.init(format:"    - sleepTime: %.2f", thread.sleepTime))
        print("")
      }
    }
  }
}
