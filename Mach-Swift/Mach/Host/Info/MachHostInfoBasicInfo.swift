//
//  MachHostInfoBasicInfo.swift
//  Mach-Swift
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 Mach-Swift. All rights reserved.
//

import Foundation

extension Mach.Host.Info {
    
    /// Host's basic info.
    public struct BasicInfo {
        public let maxCPUs: Int
        public let availCPUs: Int
        public let memorySize: UInt32	/// byte size
        public let cpuType: Int
        public let cpuSubType: Int
        public let cpuThreadType: Int
        public let physicalCPU: Int
        public let physicalCPUMax: Int
        public let logicalCPU: Int
        public let logicalCPUMax: Int
        public let maxMem: UInt64		/// byte size
    }
    
}


extension Mach.Host.Info.BasicInfo {
    
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


extension Mach.Host.Info {
    
    /// The function return host's basic info.
    /// This is wrapping the following function.
    ///
    /// - host_info(HOST_BASIC_INFO)
    ///
    /// - Returns: Host's basic info.
    public static func basicInfo() -> BasicInfo {
        
        var machData = host_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<host_basic_info>.stride / MemoryLayout<integer_t>.stride)
        
        let machRes = withUnsafeMutablePointer(to: &machData) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
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
