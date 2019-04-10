//
//  MachHostBasicInfo.swift
//  Mach-Swift
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 Mach-Swift. All rights reserved.
//

import Foundation

extension Mach.Host {
	
	public struct BasicInfo {
		let maxCPUs: Int
		let availCPUs: Int
		let memorySize: UInt32
		let cpuType: Int
		let cpuSubType: Int
		let cpuThreadType: Int
		let physicalCPU: Int
		let physicalCPUMax: Int
		let logicalCPU: Int
		let logicalCPUMax: Int
		let maxMem: UInt64
	}
	
}


extension Mach.Host.BasicInfo {
	
	public init() {
		maxCPUs = 0
		availCPUs = 0
		memorySize = 0
		cpuType = 0
		cpuSubType = 0
		cpuThreadType = 0
		physicalCPU = 0
		physicalCPUMax = 0
		logicalCPU = 0
		logicalCPUMax = 0
		maxMem = 0

	}
	
}


extension Mach.Host {

	public static func basicInfo() -> BasicInfo {
		
		var machData = host_basic_info()
		var count = mach_msg_type_number_t(MemoryLayout<host_basic_info>.stride / MemoryLayout<integer_t>.stride)
		
		let machRes = withUnsafeMutablePointer(to: &machData) {
			$0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
				host_info(mach_host_self(), HOST_BASIC_INFO, $0, &count)
			}
		}
		
		guard machRes == KERN_SUCCESS else {
			return BasicInfo()
		}
		
		
		let res = BasicInfo(
			maxCPUs: Int(machData.max_cpus),
			availCPUs: Int(machData.avail_cpus),
			memorySize: machData.memory_size,
			cpuType: Int(machData.cpu_type),
			cpuSubType: Int(machData.cpu_subtype),
			cpuThreadType: Int(machData.cpu_threadtype),
			physicalCPU: Int(machData.physical_cpu),
			physicalCPUMax: Int(machData.physical_cpu_max),
			logicalCPU: Int(machData.logical_cpu),
			logicalCPUMax: Int(machData.logical_cpu_max),
			maxMem: machData.max_mem
		)
		
		return res
	}
	
}
