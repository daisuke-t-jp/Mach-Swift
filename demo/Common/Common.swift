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
			print("# Host")

			let vm = Mach.Host.vmStatistics()
			print("## VMStatistics")
			print("- freeSize: \(vm.freeSize)")			// byte size of free
			print("- activeSize: \(vm.activeSize)")		// byte size of active
			print("- inactiveSize: \(vm.inactiveSize)")	// byte size of inactive
			print("- wireSize: \(vm.wireSize)")			// byte size of wire
			print("\n")

			let basicInfo = Mach.Host.basicInfo()
			print("## BasicInfo")
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
			print("\n")

			let cpuLoadInfo = Mach.Host.cpuLoadInfo()
			print("## CPULoadInfo")
			print("- userTick: \(cpuLoadInfo.userTick)")
			print("- systemTick: \(cpuLoadInfo.systemTick)")
			print("- idleTick: \(cpuLoadInfo.idleTick)")
			print("- niceTick: \(cpuLoadInfo.niceTick)")
			print("\n")

			let processorInfo = Mach.Host.processorInfo()
			print("## ProcessorInfo")
			for i in 0..<processorInfo.count {
				let cpu = processorInfo[i]
				print("- Core No.\(i)")
				print("    - userTick: \(cpu.userTick)")
				print("    - systemTick: \(cpu.systemTick)")
				print("    - idleTick: \(cpu.idleTick)")
				print("    - niceTick: \(cpu.niceTick)")
				print("\n")
			}
		}
		
		print("\n")
		
		do {
			print("# Task")
			
			let basicInfo = Mach.Task.basicInfo()
			print("## BasicInfo")
			print("- virtualSize: \(basicInfo.virtualSize)")
			print("- residentSize: \(basicInfo.residentSize)")
			print("- residentSizeMax: \(basicInfo.residentSizeMax)")
			print("- userTime: \(basicInfo.userTime)")
			print("- systemTime: \(basicInfo.systemTime)")
			print("- policy: \(basicInfo.policy)")
			print("- suspendCount: \(basicInfo.suspendCount)")
			print("\n")

			let threadBasicInfo = Mach.Task.threadBasicInfo()
			print("## ThreadBasicInfo")
			for i in 0..<threadBasicInfo.count {
				let thread = threadBasicInfo[i]
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
				print("\n")
			}
		}
	}
}
