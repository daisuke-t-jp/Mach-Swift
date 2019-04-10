//
//  MachHostVMStatics.swift
//  Mach-Swift
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 Mach-Swift. All rights reserved.
//

import Foundation

extension Mach.Host {
	
	public struct VMStatics {
		let freeSize: UInt64
		let activeSize: UInt64
		let inactiveSize: UInt64
		let wireSize: UInt64
	}
	
}


extension Mach.Host.VMStatics {
	
	public init() {
		freeSize = 0
		activeSize = 0
		inactiveSize = 0
		wireSize = 0
	}
	
}


extension Mach.Host {

	public static func vmStatics() -> VMStatics {
		let port = mach_host_self()
		var pageSize = vm_size_t()
		guard host_page_size(port, &pageSize) == KERN_SUCCESS else {
			return VMStatics()
		}
		
		
		var machData = vm_statistics_data_t()
		var count = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.stride / MemoryLayout<integer_t>.stride)
		
		let machRes = withUnsafeMutablePointer(to: &machData) {
			$0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
				host_statistics(port, HOST_VM_INFO, $0, &count)
			}
		}
		
		guard machRes == KERN_SUCCESS else {
			return VMStatics()
		}
		
		
		let pageSize2 = UInt64(pageSize)
		let res = VMStatics(
			freeSize: UInt64(machData.free_count) * pageSize2,
			activeSize: UInt64(machData.active_count) * pageSize2,
			inactiveSize: UInt64(machData.inactive_count) * pageSize2,
			wireSize: UInt64(machData.wire_count) * pageSize2
		)
		
		return res
	}
	
}
