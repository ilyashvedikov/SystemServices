//
//  SystemService+Localization.swift
//  SystemServices
//
//  Created by Ilya Shvedikov on 4.04.23.
//

import Foundation

extension SystemServices {
    
    var timeZone: String {
        TimeZone.current.identifier
    }
    
    var country: String {
        Locale.current.identifier
    }
    
    var language: String? {
        Locale.preferredLanguages.first
    }
    
    var currencySymbol: String? {
        Locale.current.currencySymbol
    }
    
}
