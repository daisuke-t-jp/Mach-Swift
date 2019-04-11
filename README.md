# Mach-Swift
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS%20-blue.svg)
[![Language Swift%205.0](https://img.shields.io/badge/Language-Swift%205.0-orange.svg)](https://developer.apple.com/swift)
[![Build Status](https://travis-ci.org/daisuke-t-jp/Mach-Swift.svg?branch=master)](https://travis-ci.org/daisuke-t-jp/Mach-Swift)
[![Cocoapods](https://img.shields.io/cocoapods/v/Mach-Swift.svg)](https://cocoapods.org/pods/Mach-Swift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-green.svg)](https://github.com/Carthage/Carthage)


## Introduction

You can easily get information from [Mach](https://developer.apple.com/library/archive/documentation/Darwin/Conceptual/KernelProgramming/Mach/Mach.html).  
  
The framework wrapped Mach functions in Swift.  
It provides the following information.  

- Host
    - [x] Virtual Memory Statistics
        - Wrapped [host_statistics(HOST_VM_INFO)](https://developer.apple.com/documentation/kernel/1502546-host_statistics?language=objc)
    - [x] Basic Info
        - Wrapped [host_statistics(HOST_BASIC_INFO)](https://developer.apple.com/documentation/kernel/1502546-host_statistics?language=objc)
    - [x] CPU Load Info
        - Wrapped [host_statistics(HOST_CPU_LOAD_INFO)](https://developer.apple.com/documentation/kernel/1502546-host_statistics?language=objc)
    - [x] Processor Info
        - Wrapped [host_processor_info()](https://developer.apple.com/documentation/kernel/1502854-host_processor_info?language=objc)
- Task
    - [x] Basic Info
        - Wrapped [task_info()](https://developer.apple.com/documentation/kernel/1537934-task_info?language=objc)
    - [x] Thread Basic Info
        - Wrapped [task_threads()](https://developer.apple.com/documentation/kernel/1537751-task_threads?language=objc), [thread_basic_info()](https://developer.apple.com/documentation/kernel/1418630-thread_info?language=objc)

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
print("- freeSize: \(vm.freeSize)")		// byte size of free
print("- activeSize: \(vm.activeSize)")		// byte size of active
print("- inactiveSize: \(vm.inactiveSize)")	// byte size of inactive
print("- wireSize: \(vm.wireSize)")		// byte size of wire
print("")

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
print("")

let cpuLoadInfo = Mach.Host.cpuLoadInfo()
print("## CPULoadInfo")
print("- userTick: \(cpuLoadInfo.userTick)")
print("- systemTick: \(cpuLoadInfo.systemTick)")
print("- idleTick: \(cpuLoadInfo.idleTick)")
print("- niceTick: \(cpuLoadInfo.niceTick)")
print("")

let processorInfo = Mach.Host.processorInfo()
print("## ProcessorInfo")
for i in 0..<processorInfo.count {
	let cpu = processorInfo[i]
	print("- Core No.\(i)")
	print("    - userTick: \(cpu.userTick)")
	print("    - systemTick: \(cpu.systemTick)")
	print("    - idleTick: \(cpu.idleTick)")
	print("    - niceTick: \(cpu.niceTick)")
	print("")
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
print("")

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
	print("")
}
```


## Demo
There are demos.
- [iOS](https://github.com/daisuke-t-jp/Mach-Swift/tree/master/demo/Mach-SwiftDemo-iOS) 
- [macOS](https://github.com/daisuke-t-jp/Mach-Swift/tree/master/demo/Mach-SwiftDemo-macOS) 
