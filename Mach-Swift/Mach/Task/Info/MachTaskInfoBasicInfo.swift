//
//  MachTaskInfoBasicInfo.swift
//  Mach-Swift
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 Mach-Swift. All rights reserved.
//

import Foundation

extension Mach.Task.Info {
    
    /// Task's basic info.
    public struct BasicInfo {
        public let virtualSize: UInt64		/// byte size
        public let residentSize: UInt64		/// byte size
        public let residentSizeMax: UInt64	/// byte size
        public let userTime: TimeInterval
        public let systemTime: TimeInterval
        public let policy: Int
        public let suspendCount: Int
    }
    
}


extension Mach.Task.Info.BasicInfo {
    
    public init() {
        virtualSize = 0
        residentSize = 0
        residentSizeMax = 0
        userTime = 0
        systemTime = 0
        policy = 0
        suspendCount = 0
    }
    
}


extension Mach.Task.Info {
    
    /// The function return task's basic info.
    /// This is wrapping the following function.
    ///
    /// - task_info()
    ///
    /// - Returns: Task's basic info.
    public static func basicInfo() -> BasicInfo {
        var machData = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.stride / MemoryLayout<integer_t>.stride)
        
        let machRes = withUnsafeMutablePointer(to: &machData) {
            task_info(mach_task_self_,
                      task_flavor_t(MACH_TASK_BASIC_INFO),
                      $0.withMemoryRebound(to: Int32.self, capacity: 1) { pointer in
                        UnsafeMutablePointer<Int32>(pointer)
                      }, &count)
        }
        
        guard machRes == KERN_SUCCESS else {
            return BasicInfo()
        }
        
        let res = BasicInfo(
            virtualSize: machData.virtual_size,
            residentSize: machData.resident_size,
            residentSizeMax: machData.resident_size_max,
            userTime: TimeInterval(machData.user_time),
            systemTime: TimeInterval(machData.system_time),
            policy: Int(machData.policy),
            suspendCount: Int(machData.suspend_count)
        )
        
        return res
    }
}
