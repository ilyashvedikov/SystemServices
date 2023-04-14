//
//  SystemServices+Disk.swift
//  SystemServices
//
//  Created by Ilya Shvedikov on 5.04.23.
//

import Foundation

extension SystemServices {
    
    public var totalDiskSpaceRaw: Int64? {
        diskAttribute(for: .systemSize)
    }
    
    public var freeDiskSpaceRaw: Int64? {
        diskAttribute(for: .systemFreeSize)
    }
    
    public var usedDiskSpaceRaw: Int64? {
        (totalDiskSpaceRaw ?? 0) - (freeDiskSpaceRaw ?? 0)
    }
}

private extension SystemServices {
    
    func diskAttribute(for key: FileAttributeKey) -> Int64? {
        try? (
            FileManager.default.attributesOfFileSystem(
                forPath: NSHomeDirectory()
            )[key] as? NSNumber
        )?.int64Value
    }
    
}
