//
//  MachHostProcessorCPULoadInfo.swift
//  Mach-Swift
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 Mach-Swift. All rights reserved.
//

import Foundation

extension Mach.Host.Processor {
    
    /// The function return an array of host's processor info.
    /// This is wrapping the following function.
    ///
    /// - host_processor_info()
    ///
    /// - Returns: An array of host's processor info.
    public static func cpuLoadInfoArray() -> [Mach.CPUTick] {
        var cpuCount: natural_t = 0
        var cpuInfoArray: processor_info_array_t?
        var cpuInfoCount: mach_msg_type_number_t = 0
        guard KERN_SUCCESS == host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &cpuCount, &cpuInfoArray, &cpuInfoCount) else {
            return [Mach.CPUTick]()
        }
        
        do {
            guard cpuCount > 0 else {
                return [Mach.CPUTick]()
            }
            guard let cpuInfoArray = cpuInfoArray else {
                return [Mach.CPUTick]()
            }
            defer {
                vm_deallocate(mach_task_self_, vm_address_t(cpuInfoArray.pointee), vm_size_t(cpuInfoCount))
            }
            
            var array = [Mach.CPUTick]()
            for i in 0..<cpuCount {
                let index = Int32(i) * CPU_STATE_MAX
                let tick = Mach.CPUTick(
                    userTick: UInt32(cpuInfoArray[Int(index + CPU_STATE_USER)]),
                    systemTick: UInt32(cpuInfoArray[Int(index + CPU_STATE_SYSTEM)]),
                    idleTick: UInt32(cpuInfoArray[Int(index + CPU_STATE_IDLE)]),
                    niceTick: UInt32(cpuInfoArray[Int(index + CPU_STATE_NICE)])
                )
                
                array.append(tick)
            }
            
            return array
        }
    }
}
