//
//  SystemServices+Environment.swift
//  SystemServices
//
//  Created by Ilya Shvedikov on 4.04.23.
//

import Foundation
import UIKit

extension SystemServices {
    
    public var displayName: String? {
        Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
    }
    
    public var appVersion: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    public var buildNumber: String? {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
    public var systemVersion: String {
        UIDevice.current.systemVersion
    }
    
    public var testFlight: Bool {
        Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
    }
    
    public var debug: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    public var testEnvironment: Bool {
        debug || testFlight
    }
    
    
}
