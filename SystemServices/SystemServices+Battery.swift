//
//  SystemServices+Battery.swift
//  SystemServices
//
//  Created by Ilya Shvedikov on 4.04.23.
//

import Foundation
import UIKit

extension SystemServices {
    
    var fullyCharged: Bool {
        let device = UIDevice.current
        defer { device.isBatteryMonitoringEnabled = false }
        device.isBatteryMonitoringEnabled = true
        
        return device.batteryState == .full
    }
    
    var charging: Bool {
        let device = UIDevice.current
        defer { device.isBatteryMonitoringEnabled = false }
        device.isBatteryMonitoringEnabled = true
        
        return device.batteryState == .charging
    }
    
}
