//
//  MachTaskThreadBasicInfo.swift
//  Mach-Swift
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 Mach-Swift. All rights reserved.
//

import Foundation

extension Mach.Task.Thread {
    
    public typealias State = Int32
    public static let stateRunning = TH_STATE_RUNNING	// thread is running normally
    public static let stateStopped = TH_STATE_STOPPED	// thread is stopped
    public static let stateWaiting = TH_STATE_WAITING	// thread is waiting normally
    public static let stateUninterruptible = TH_STATE_UNINTERRUPTIBLE	// thread is in an uninterruptible wait
    public static let stateHalted = TH_STATE_HALTED		// thread is halted at a clean point
    
    public struct Flag: OptionSet {
        public let rawValue: Int32
        public static let swapped = Flag(rawValue: TH_FLAGS_SWAPPED)	// thread is swapped out
        public static let idle = Flag(rawValue: TH_FLAGS_IDLE)		// thread is an idle thread
        public static let globalForcedIdle = Flag(rawValue: TH_FLAGS_GLOBAL_FORCED_IDLE)	// thread performs global forced idle
        
        public init(rawValue: Int32) {
            self.rawValue = rawValue
        }
    }
    
    /// Task's thread basic info.
    public struct BasicInfo {
        public let userTime: TimeInterval		// user run time
        public let systemTime: TimeInterval		// system run time
        public let cpuUsage: Int				// scaled cpu usage percentage
        public let policy: Int					// scheduling policy in effect
        public let runState: State		// run state
        public let flags: Flag			// various flags
        public let suspendCount: Int			// suspend count for thread
        public let sleepTime: TimeInterval		// number of seconds that thread has been sleeping
    }
    
}


extension Mach.Task.Thread.BasicInfo {
    
    public init() {
        userTime = 0
        systemTime = 0
        cpuUsage = 0
        policy = 0
        runState = Mach.Task.Thread.stateStopped
        flags = .idle
        suspendCount = 0
        sleepTime = 0
    }
    
}


extension Mach.Task.Thread {
    
    /// The function return an array of task's thread basic info.
    /// This is wrapping the following function.
    ///
    /// - task_threads()
    /// - thread_info()
    ///
    /// - Returns: An array of task's thread basic info.
    public static func basicInfoArray() -> [BasicInfo] {
        var actList: thread_act_array_t?
        var actListCount: mach_msg_type_number_t = 0
        guard KERN_SUCCESS == task_threads(mach_task_self_, &actList, &actListCount) else {
            return [BasicInfo]()
        }
        
        do {
            guard actListCount > 0 else {
                return [BasicInfo]()
            }
            guard let actList = actList else {
                return [BasicInfo]()
            }
            defer {
                vm_deallocate(mach_task_self_, vm_address_t(actList.pointee), vm_size_t(actListCount))
            }
            
            
            var array = [BasicInfo]()
            for i in 0..<actListCount {
                var machData = thread_basic_info()
                var count = UInt32(THREAD_INFO_MAX)
                
                let machRes = withUnsafeMutablePointer(to: &machData) {
                    $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                        thread_info(actList[Int(i)], thread_flavor_t(THREAD_BASIC_INFO), $0, &count)
                    }
                }
                guard machRes == KERN_SUCCESS else {
                    return [BasicInfo]()
                }
                
                let info = BasicInfo(
                    userTime: TimeInterval(machData.user_time),
                    systemTime: TimeInterval(machData.system_time),
                    cpuUsage: Int(machData.cpu_usage),
                    policy: Int(machData.policy),
                    runState: State(machData.run_state),
                    flags: Flag(rawValue: machData.flags),
                    suspendCount: Int(machData.suspend_count),
                    sleepTime: TimeInterval(machData.sleep_time)
                )
                
                array.append(info)
            }
            
            return array
        }
    }
    
    public static func basicInfoIsIdle(_ basicInfo: BasicInfo) -> Bool {
        if basicInfo.flags.contains(Flag.idle) {
            return true
        }
        
        if basicInfo.flags.contains(Flag.globalForcedIdle) {
            return true 
        }
        
        return false
    }
    
}
