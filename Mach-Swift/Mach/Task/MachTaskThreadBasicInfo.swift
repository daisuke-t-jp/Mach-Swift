//
//  MachTaskThreadBasicInfo.swift
//  Mach-Swift
//
//  Created by Daisuke T on 2019/03/15.
//  Copyright © 2019 Mach-Swift. All rights reserved.
//

import Foundation

extension Mach.Task {
	
	typealias ThreadState = Int32
	static let ThreadStateRunning = TH_STATE_RUNNING	// thread is running normally
	static let ThreadStateStopped = TH_STATE_STOPPED	// thread is stopped
	static let ThreadStateWaiting = TH_STATE_WAITING	// thread is waiting normally
	static let ThreadStateUninterruptible = TH_STATE_UNINTERRUPTIBLE	// thread is in an uninterruptible wait
	static let ThreadStateHalted = TH_STATE_HALTED		// thread is halted at a clean point
	
	struct ThreadFlag: OptionSet {
		let rawValue: Int32
		static let swapped = ThreadFlag(rawValue: TH_FLAGS_SWAPPED)	// thread is swapped out
		static let idle = ThreadFlag(rawValue: TH_FLAGS_IDLE)		// thread is an idle thread
		static let globalForcedIdle = ThreadFlag(rawValue: TH_FLAGS_GLOBAL_FORCED_IDLE)	// thread performs global forced idle
	}
	
	struct ThreadBasicInfo {
		let userTime: TimeInterval		// user run time
		let systemTime: TimeInterval	// system run time
		let cpuUsage: Int				// scaled cpu usage percentage
		let policy: Int					// scheduling policy in effect
		let runState: ThreadState		// run state
		let flags: ThreadFlag			// various flags
		let suspendCount: Int			// suspend count for thread
		let sleepTime: TimeInterval		// number of seconds that thread has been sleeping
	}
	
}


extension Mach.Task.ThreadBasicInfo {
	
	init() {
		userTime = 0
		systemTime = 0
		cpuUsage = 0
		policy = 0
		runState = Mach.Task.ThreadStateStopped
		flags = .idle
		suspendCount = 0
		sleepTime = 0
	}
	
}


extension Mach.Task {

	static func threadBasicInfo() -> [ThreadBasicInfo] {
		var actList: thread_act_array_t?
		var actListCount: mach_msg_type_number_t = 0
		guard KERN_SUCCESS == task_threads(mach_task_self_, &actList, &actListCount) else {
			return [ThreadBasicInfo]()
		}
		
		do {
			guard actListCount > 0 else {
				return [ThreadBasicInfo]()
			}
			guard let actList = actList else {
				return [ThreadBasicInfo]()
			}
			defer {
				vm_deallocate(mach_task_self_, vm_address_t(actList.pointee), vm_size_t(actListCount))
			}
			
			
			var array = [ThreadBasicInfo]()
			for i in 0..<actListCount {
				var machData = thread_basic_info()
				var count = UInt32(THREAD_INFO_MAX)
				
				let machRes = withUnsafeMutablePointer(to: &machData) {
					$0.withMemoryRebound(to: integer_t.self, capacity: 1) {
						thread_info(actList[Int(i)], thread_flavor_t(THREAD_BASIC_INFO), $0, &count)
					}
				}
				guard machRes == KERN_SUCCESS else {
					return [ThreadBasicInfo]()
				}
				
				let info = ThreadBasicInfo(
					userTime: TimeInterval(machData.user_time),
					systemTime: TimeInterval(machData.system_time),
					cpuUsage: Int(machData.cpu_usage),
					policy: Int(machData.policy),
					runState: ThreadState(machData.run_state),
					flags: ThreadFlag(rawValue: machData.flags),
					suspendCount: Int(machData.suspend_count),
					sleepTime: TimeInterval(machData.sleep_time)
				)
				
				array.append(info)
			}
			
			return array
		}
	}
	
	static func threadBasicInfoIsIdle(_ threadBasicInfo: ThreadBasicInfo) -> Bool {
		if threadBasicInfo.flags.contains(ThreadFlag.idle) {
			return true
		}
		
		if threadBasicInfo.flags.contains(ThreadFlag.globalForcedIdle) {
			return true
		}
		
		return false
	}
	
}
