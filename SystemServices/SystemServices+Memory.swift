//
//  SystemServices+Memory.swift
//  SystemServices
//
//  Created by Ilya Shvedikov on 4.04.23.
//

import UIKit
import MachO
import SystemConfiguration

extension SystemServices {

    public var totalMemory: UInt64 {
        return ProcessInfo.processInfo.physicalMemory
    }
    
}

