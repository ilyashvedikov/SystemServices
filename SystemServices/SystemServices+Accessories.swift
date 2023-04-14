//
//  SystemServices+Accessories.swift
//  SystemServices
//
//  Created by Ilya Shvedikov on 4.04.23.
//

import Foundation
import ExternalAccessory
import AVFoundation

extension SystemServices {
    
    public var accessoriesAttached: Bool {
        numberOfAttachedAccessories > 0
    }
    
    public var numberOfAttachedAccessories: Int {
        connectedAccessories.count
    }
    
    public var headphonesAttached: Bool {
        AVAudioSession.sharedInstance().currentRoute.outputs.contains(where: { $0.portType == .headphones })
    }
    
    public var attachedAccessoriesNames: String {
        connectedAccessories.map { $0.manufacturer }.joined(separator: ",")
    }
    
    private var connectedAccessories: [EAAccessory] {
        EAAccessoryManager.shared().connectedAccessories
    }
    
}
