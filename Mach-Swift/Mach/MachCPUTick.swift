//
//  MachCPUTick.swift
//  Mach-Swift
//
//  Created by Daisuke T on 2019/03/14.
//  Copyright © 2019 Mach-Swift. All rights reserved.
//

import Foundation

extension Mach {
    
    public struct CPUTick {
        public let userTick: UInt32
        public let systemTick: UInt32
        public let idleTick: UInt32
        public let niceTick: UInt32
    }
    
}

extension Mach.CPUTick {
    
    public init() {
        userTick = 0
        systemTick = 0
        idleTick = 0
        niceTick = 0
    }
    
}
