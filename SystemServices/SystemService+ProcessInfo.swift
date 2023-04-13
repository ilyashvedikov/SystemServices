//
//  SystemService+ProcessInfo.swift
//  SystemServices
//
//  Created by Ilya Shvedikov on 5.04.23.
//

import Foundation

extension SystemServices {
    
    var processId: Int {
        Int(getpid())
    }
    
}
