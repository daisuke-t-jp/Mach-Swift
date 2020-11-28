//
//  MachHostStatisticsCPULoadInfo.swift
//  Mach-Swift
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 Mach-Swift. All rights reserved.
//

import Foundation

extension Mach.Host.Statistics {
    
    /// The function return host's cpu load info.
    /// This is wrapping the following function.
    ///
    /// - host_statistics(HOST_CPU_LOAD_INFO)
    ///
    /// - Returns: Host's cpu load info.
    public static func cpuLoadInfo() -> Mach.CPUTick {
        var machData = host_cpu_load_info()
        var count = mach_msg_type_number_t(MemoryLayout<host_cpu_load_info>.stride / MemoryLayout<integer_t>.stride)
        
        let machRes = withUnsafeMutablePointer(to: &machData) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, $0, &count)
            }
        }
        
        guard machRes == KERN_SUCCESS else {
            return Mach.CPUTick()
        }
        
        let res = Mach.CPUTick(
            userTick: machData.cpu_ticks.0, // CPU_STATE_USER
            systemTick: machData.cpu_ticks.1,	// CPU_STATE_SYSTEM
            idleTick: machData.cpu_ticks.2,	// CPU_STATE_IDLE
            niceTick: machData.cpu_ticks.3 // CPU_STATE_NICE
        )
        
        return res
    }
}
