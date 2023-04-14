//
//  SystemService+Localization.swift
//  SystemServices
//
//  Created by Ilya Shvedikov on 4.04.23.
//

import Foundation

extension SystemServices {
    
    public var timeZone: String {
        TimeZone.current.identifier
    }
    
    public var country: String {
        Locale.current.identifier
    }
    
    public var language: String? {
        Locale.preferredLanguages.first
    }
    
    public var currencySymbol: String? {
        Locale.current.currencySymbol
    }
    
}
