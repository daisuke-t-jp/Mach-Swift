<img src="https://raw.githubusercontent.com/daisuke-t-jp/Mach-Swift/master/images/Mach-Swift.png" width="300"></br>
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
    - Statistics
        - [x] Virtual Memory Statistics / Wrapped [host_statistics(HOST_VM_INFO)](https://developer.apple.com/documentation/kernel/1502546-host_statistics?language=objc)
        - [x] CPU Load Info / Wrapped [host_statistics(HOST_CPU_LOAD_INFO)](https://developer.apple.com/documentation/kernel/1502546-host_statistics?language=objc)
    - Info
        - [x] Basic Info / Wrapped [host_info(HOST_BASIC_INFO)](https://developer.apple.com/documentation/kernel/1502514-host_info?language=objc)
    - Processor
        - [x] CPU Load Info / Wrapped [host_processor_info()](https://developer.apple.com/documentation/kernel/1502854-host_processor_info?language=objc)
- Task
    - Info
        - [x] Basic Info / Wrapped [task_info()](https://developer.apple.com/documentation/kernel/1537934-task_info?language=objc)
    - Thread
        - [x] Basic Info / Wrapped [task_threads()](https://developer.apple.com/documentation/kernel/1537751-task_threads?language=objc), [thread_info()](https://developer.apple.com/documentation/kernel/1418630-thread_info?language=objc)

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

### Getting Information
#### Code
```swift
do {
    print("# Mach")
    
    print("## Host")
    print("### Statistics")
    print("#### VMInfo")
    let vm = Mach.Host.Statistics.vmInfo()
    print("- freeSize: \(vm.freeSize)")  // byte size of free
    print("- activeSize: \(vm.activeSize)")  // byte size of active
    print("- inactiveSize: \(vm.inactiveSize)")  // byte size of inactive
    print("- wireSize: \(vm.wireSize)")  // byte size of wire
    print("")

    print("#### CPULoadInfo")
    let cpuLoadInfo = Mach.Host.Statistics.cpuLoadInfo()
    print("- userTick: \(cpuLoadInfo.userTick)")
    print("- systemTick: \(cpuLoadInfo.systemTick)")
    print("- idleTick: \(cpuLoadInfo.idleTick)")
    print("- niceTick: \(cpuLoadInfo.niceTick)")
    print("")
    
    print("### Info")
    print("#### BasicInfo")
    let basicInfo = Mach.Host.Info.basicInfo()
    print("- maxCPUs: \(basicInfo.maxCPUs)")
    print("- availCPUs: \(basicInfo.availCPUs)")
    print("- memorySize: \(basicInfo.memorySize)")  // byte size
    print("- cpuType: \(basicInfo.cpuType)")
    print("- cpuSubType: \(basicInfo.cpuSubType)")
    print("- cpuThreadType: \(basicInfo.cpuThreadType)")
    print("- physicalCPU: \(basicInfo.physicalCPU)")
    print("- physicalCPUMax: \(basicInfo.physicalCPUMax)")
    print("- logicalCPU: \(basicInfo.logicalCPU)")
    print("- logicalCPUMax: \(basicInfo.logicalCPUMax)")
    print("- maxMem: \(basicInfo.maxMem)")  // byte size
    print("")
  
    print("### Processor")
    print("#### CPULoadInfo")
    let array = Mach.Host.Processor.cpuLoadInfoArray()
    for i in 0..<array.count {
        let cpu = array[i]
        print("- Core No.\(i)")
        print("    - userTick: \(cpu.userTick)")
        print("    - systemTick: \(cpu.systemTick)")
        print("    - idleTick: \(cpu.idleTick)")
        print("    - niceTick: \(cpu.niceTick)")
        print("")
    }
}

print("")


do {
    print("## Task")
    print("### Info")
    print("#### BasicInfo")
    let basicInfo = Mach.Task.Info.basicInfo()
    print("- virtualSize: \(basicInfo.virtualSize)")
    print("- residentSize: \(basicInfo.residentSize)")
    print("- residentSizeMax: \(basicInfo.residentSizeMax)")
    print("- userTime: \(basicInfo.userTime)")
    print("- systemTime: \(basicInfo.systemTime)")
    print("- policy: \(basicInfo.policy)")
    print("- suspendCount: \(basicInfo.suspendCount)")
    print("")
  
    print("#### ThreadBasicInfo")
    let array = Mach.Task.Thread.basicInfoArray()
    for i in 0..<array.count {
        let thread = array[i]
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
}
```

#### Outout
```
# Mach
## Host
### Statistics
#### VMInfo
- freeSize: 130482176
- activeSize: 1765789696
- inactiveSize: 1649594368
- wireSize: 2495418368

#### CPULoadInfo
- userTick: 785470
- systemTick: 503253
- idleTick: 4632473
- niceTick: 0

### Info
#### BasicInfo
- maxCPUs: 4
- availCPUs: 4
- memorySize: 2147483648
- cpuType: 7
- cpuSubType: 8
- cpuThreadType: 1
- physicalCPU: 2
- physicalCPUMax: 2
- logicalCPU: 4
- logicalCPUMax: 4
- maxMem: 8589934592

### Processor
#### CPULoadInfo
- Core No.0
    - userTick: 257206
    - systemTick: 186605
    - idleTick: 1036690
    - niceTick: 0

- Core No.1
    - userTick: 144763
    - systemTick: 87848
    - idleTick: 1247622
    - niceTick: 0

- Core No.2
    - userTick: 251769
    - systemTick: 155100
    - idleTick: 1073364
    - niceTick: 0

- Core No.3
    - userTick: 131732
    - systemTick: 73700
    - idleTick: 1274800
    - niceTick: 0


## Task
### Info
#### BasicInfo
- virtualSize: 5425922048
- residentSize: 78155776
- residentSizeMax: 78155776
- userTime: 0.000426
- systemTime: 0.003031
- policy: 1
- suspendCount: 0

#### ThreadBasicInfo
- Thread No.0
    - userTime: 0.24
    - systemTime: 0.93
    - cpuUsage: 626
    - policy: 1
    - runState: 1
    - flags: Flag(rawValue: 0)
    - suspendCount: 0
    - sleepTime: 0.0
    - sleepTime: 0.00

- Thread No.1
    - userTime: 0.01
    - systemTime: 0.01
    - cpuUsage: 23
    - policy: 1
    - runState: 3
    - flags: Flag(rawValue: 1)
    - suspendCount: 0
    - sleepTime: 0.0
    - sleepTime: 0.00

- Thread No.2
    - userTime: 0.00
    - systemTime: 0.00
    - cpuUsage: 6
    - policy: 1
    - runState: 3
    - flags: Flag(rawValue: 1)
    - suspendCount: 0
    - sleepTime: 0.0
    - sleepTime: 0.00

- Thread No.3
    - userTime: 0.00
    - systemTime: 0.00
    - cpuUsage: 0
    - policy: 1
    - runState: 3
    - flags: Flag(rawValue: 1)
    - suspendCount: 0
    - sleepTime: 0.0
    - sleepTime: 0.00

- Thread No.4
    - userTime: 0.00
    - systemTime: 0.00
    - cpuUsage: 4
    - policy: 1
    - runState: 3
    - flags: Flag(rawValue: 1)
    - suspendCount: 0
    - sleepTime: 0.0
    - sleepTime: 0.00

- Thread No.5
    - userTime: 0.00
    - systemTime: 0.01
    - cpuUsage: 12
    - policy: 1
    - runState: 3
    - flags: Flag(rawValue: 1)
    - suspendCount: 0
    - sleepTime: 0.0
    - sleepTime: 0.00

```


## Demo
There are demos.
- [iOS](https://github.com/daisuke-t-jp/Mach-Swift/tree/master/demo/Mach-SwiftDemo-iOS) 
- [macOS](https://github.com/daisuke-t-jp/Mach-Swift/tree/master/demo/Mach-SwiftDemo-macOS) 
