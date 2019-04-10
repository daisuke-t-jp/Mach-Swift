# Mach-Swift
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS%20-blue.svg)
[![Language Swift%205.0](https://img.shields.io/badge/Language-Swift%205.0-orange.svg)](https://developer.apple.com/swift)
[![Build Status](https://travis-ci.org/daisuke-t-jp/Mach-Swift.svg?branch=master)](https://travis-ci.org/daisuke-t-jp/Mach-Swift)


## Introduction

**Mach-Swift** framework wrapped [Mach](https://developer.apple.com/library/archive/documentation/Darwin/Conceptual/KernelProgramming/Mach/Mach.html) functions.
The framework provides the following information.  

- Host
    - [x] Virtual Memory Statistics
        - Wrapped *host_statistics(, HOST_VM_INFO, ,)*
    - [x] Basic Info
        - Wrapped *host_statistics(, HOST_BASIC_INFO, , )*
    - [x] CPU Load Info
        - Wrapped *host_statistics(, HOST_CPU_LOAD_INFO, , )*
    - [x] Processor Info
        - Wrapped *host_processor_info()*
- Task
    - [x] Basic Info
        - Wrapped *task_info()*
    - [x] Thread Basic Info
        - Wrapped *task_threads(), thread_basic_info()*

## Requirements
- Platforms
  - iOS 10.0+
  - macOS 10.12+
- Swift 5.0


## Installation
### Carthage
```
github "daisuke-t-jp/Mach-Swift"
```

### CocoaPods
```
use_frameworks!

target 'target' do
pod 'Mach-Swift'
end
```


## Usage
### Import framework
```swift
import Mach_Swift
```

### Getting Host Information

```swift
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
```

### Getting Task Information

```swift
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
```


## Demo
There are demos.
- [iOS](https://github.com/daisuke-t-jp/Mach-Swift/tree/master/demo/Mach-SwiftDemo-iOS) 
- [macOS](https://github.com/daisuke-t-jp/Mach-Swift/tree/master/demo/Mach-SwiftDemo-macOS) 