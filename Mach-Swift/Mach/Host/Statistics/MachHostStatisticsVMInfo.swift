//
//  MachHostStatisticsVMInfo.swift
//  Mach-Swift
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 Mach-Swift. All rights reserved.
//

import Foundation

extension Mach.Host.Statistics {
    
    /// Host's virtual memory statistics.
    public struct VMInfo {
        public let freeSize: UInt64			/// byte size of free.
        public let activeSize: UInt64		/// byte size of active.
        public let inactiveSize: UInt64		/// byte size of inactive.
        public let wireSize: UInt64			/// byte size of wire.
    }
    
}


extension Mach.Host.Statistics.VMInfo {
    
    public init() {
        freeSize = 0
        activeSize = 0
        inactiveSize = 0
        wireSize = 0
    }
    
}


extension Mach.Host.Statistics {
    
    /// The function return host's virtual memory statistics.
    /// This is wrapping the following function.
    ///
    /// - host_statistics(HOST_VM_INFO)
    ///
    /// - Returns: Host's virtual memory statistics.
    public static func vmInfo() -> VMInfo {
        let port = mach_host_self()
        var pageSize = vm_size_t()
        guard host_page_size(port, &pageSize) == KERN_SUCCESS else {
            return VMInfo()
        }
        
        
        var machData = vm_statistics_data_t()
        var count = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.stride / MemoryLayout<integer_t>.stride)
        
        let machRes = withUnsafeMutablePointer(to: &machData) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                host_statistics(port, HOST_VM_INFO, $0, &count)
            }
        }
        
        guard machRes == KERN_SUCCESS else {
            return VMInfo()
        }
        
        
        let pageSize2 = UInt64(pageSize)
        let res = VMInfo(
            freeSize: UInt64(machData.free_count) * pageSize2,
            activeSize: UInt64(machData.active_count) * pageSize2,
            inactiveSize: UInt64(machData.inactive_count) * pageSize2,
            wireSize: UInt64(machData.wire_count) * pageSize2
        )
        
        return res
    }
    
}
