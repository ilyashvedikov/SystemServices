//
//  SystemServices+Jailbreak.swift
//  SystemServices
//
//  Created by Ilya Shvedikov on 5.04.23.
//

import Foundation
import UIKit
import MachO
import IOSSecuritySuite

extension SystemServices {
    
    public var isJailbroken: Bool {
        #if os(iOS)
        IOSSecuritySuite.amIJailbroken()
        #else
        false
        #endif
    }
    
}
