//
//  SystemServices+Processor.swift
//  SystemServices
//
//  Created by Ilya Shvedikov on 5.04.23.
//

import Foundation

extension SystemServices {
    
    var numberOfProcessors: Int {
        ProcessInfo.processInfo.processorCount
    }
    
    var numberOfActiveProcessors: Int {
        ProcessInfo.processInfo.activeProcessorCount
    }

}
