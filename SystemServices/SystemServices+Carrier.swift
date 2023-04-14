//
//  SystemServices+Carrier.swift
//  SystemServices
//
//  Created by Ilya Shvedikov on 4.04.23.
//

import Foundation
import CoreTelephony

extension SystemServices {
    
    public var carrierName: String? {
        CTTelephonyNetworkInfo().serviceSubscriberCellularProviders?.first?.value.carrierName
    }
    
    public var carrierISOCountryCode: String? {
        CTTelephonyNetworkInfo().serviceSubscriberCellularProviders?.first?.value.isoCountryCode
    }
    
    public var carrierMobileCountryCode: String? {
        CTTelephonyNetworkInfo().serviceSubscriberCellularProviders?.first?.value.mobileCountryCode
    }
    
    public var carrierMobileNetworkCode: String? {
        CTTelephonyNetworkInfo().serviceSubscriberCellularProviders?.first?.value.mobileNetworkCode
    }
    
    public var carrierAllowsVoip: Bool {
        CTTelephonyNetworkInfo().serviceSubscriberCellularProviders?.first?.value.allowsVOIP ?? false
    }
    
}
