//
//  SystemService+ProcessInfo.swift
//  SystemServices
//
//  Created by Ilya Shvedikov on 5.04.23.
//

import Foundation

extension SystemServices {
    
    public var processId: Int {
        Int(getpid())
    }
    
}
