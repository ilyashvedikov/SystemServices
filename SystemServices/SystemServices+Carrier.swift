//
//  SystemServices+Carrier.swift
//  SystemServices
//
//  Created by Ilya Shvedikov on 4.04.23.
//

import Foundation
import CoreTelephony

extension SystemServices {
    
    var carrierName: String? {
        CTTelephonyNetworkInfo().serviceSubscriberCellularProviders?.first?.value.carrierName
    }
    
    var carrierISOCountryCode: String? {
        CTTelephonyNetworkInfo().serviceSubscriberCellularProviders?.first?.value.isoCountryCode
    }
    
    var carrierMobileCountryCode: String? {
        CTTelephonyNetworkInfo().serviceSubscriberCellularProviders?.first?.value.mobileCountryCode
    }
    
    var carrierMobileNetworkCode: String? {
        CTTelephonyNetworkInfo().serviceSubscriberCellularProviders?.first?.value.mobileNetworkCode
    }
    
    var carrierAllowsVoip: Bool {
        CTTelephonyNetworkInfo().serviceSubscriberCellularProviders?.first?.value.allowsVOIP ?? false
    }
    
}
