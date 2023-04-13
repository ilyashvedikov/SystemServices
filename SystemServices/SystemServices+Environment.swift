//
//  SystemServices+Environment.swift
//  SystemServices
//
//  Created by Ilya Shvedikov on 4.04.23.
//

import Foundation
import UIKit

extension SystemServices {
    
    var displayName: String? {
        Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
    }
    
    var appVersion: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildNumber: String? {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
    var systemVersion: String {
        UIDevice.current.systemVersion
    }
    
    var testFlight: Bool {
        Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
    }
    
    var debug: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    var testEnvironment: Bool {
        debug || testFlight
    }
    
    
}
