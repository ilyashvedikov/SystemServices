//
//  SystemServices+Processor.swift
//  SystemServices
//
//  Created by Ilya Shvedikov on 5.04.23.
//

import Foundation

extension SystemServices {
    
    public var numberOfProcessors: Int {
        ProcessInfo.processInfo.processorCount
    }
    
    public var numberOfActiveProcessors: Int {
        ProcessInfo.processInfo.activeProcessorCount
    }

}
