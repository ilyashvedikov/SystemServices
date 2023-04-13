//
//  SustemServices+Networking.swift
//  SystemServices
//
//  Created by Ilya Shvedikov on 4.04.23.
//

import Foundation

extension SystemServices {
    
    private enum NetworkInterface: String {
        case wifi = "en0"
        case cellular = "pdp_ip0"
    }
    
    private static let RTAX_GATEWAY = 1
    private static let RTAX_MAX = 8
    
    private struct rt_metrics {
        public var rmx_locks: UInt32 /* Kernel leaves these values alone */
        public var rmx_mtu: UInt32 /* MTU for this path */
        public var rmx_hopcount: UInt32 /* max hops expected */
        public var rmx_expire: Int32 /* lifetime for route, e.g. redirect */
        public var rmx_recvpipe: UInt32 /* inbound delay-bandwidth product */
        public var rmx_sendpipe: UInt32 /* outbound delay-bandwidth product */
        public var rmx_ssthresh: UInt32 /* outbound gateway buffer limit */
        public var rmx_rtt: UInt32 /* estimated round trip time */
        public var rmx_rttvar: UInt32 /* estimated rtt variance */
        public var rmx_pksent: UInt32 /* packets sent using this route */
        public var rmx_state: UInt32 /* route state */
        public var rmx_filler: (UInt32, UInt32, UInt32) /* will be used for TCP's peer-MSS cache */
    }
    
    private struct rt_msghdr2 {
        public var rtm_msglen: u_short /* to skip over non-understood messages */
        public var rtm_version: u_char /* future binary compatibility */
        public var rtm_type: u_char /* message type */
        public var rtm_index: u_short /* index for associated ifp */
        public var rtm_flags: Int32 /* flags, incl. kern & message, e.g. DONE */
        public var rtm_addrs: Int32 /* bitmask identifying sockaddrs in msg */
        public var rtm_refcnt: Int32 /* reference count */
        public var rtm_parentflags: Int32 /* flags of the parent route */
        public var rtm_reserved: Int32 /* reserved field set to 0 */
        public var rtm_use: Int32 /* from rtentry */
        public var rtm_inits: UInt32 /* which metrics we are initializing */
        public var rtm_rmx: rt_metrics /* metrics themselves */
    }

    
    var wifiIpAddress: String? {
        getIpAddress(.wifi)
    }
    
    var cellularIpAddress: String? {
        getIpAddress(.cellular)
    }
    
    var currentIpAddress: String? {
        wifiIpAddress ?? cellularIpAddress
    }
    
    var wifiRouterAddress: String? {
        var name: [Int32] = [
            CTL_NET,
            PF_ROUTE,
            0,
            0,
            NET_RT_DUMP2,
            0
        ]
        let nameSize = u_int(name.count)
        
        var bufferSize = 0
        sysctl(&name, nameSize, nil, &bufferSize, nil, 0)
        
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        defer { buffer.deallocate() }
        buffer.initialize(repeating: 0, count: bufferSize)
        
        guard sysctl(&name, nameSize, buffer, &bufferSize, nil, 0) == 0 else { return nil }
        
        var rt = buffer
        let end = rt.advanced(by: bufferSize)
        while rt < end {
            let msg = rt.withMemoryRebound(to: rt_msghdr2.self, capacity: 1) { $0.pointee }
            
            var addr = rt.advanced(by: MemoryLayout<rt_msghdr2>.stride)
            for i in 0..<Self.RTAX_MAX {
                if (msg.rtm_addrs & (1 << i)) != 0 && i == Self.RTAX_GATEWAY {
                    let si = addr.withMemoryRebound(to: sockaddr_in.self, capacity: 1) { $0.pointee }
                    if si.sin_addr.s_addr == INADDR_ANY {
                        return "default"
                    }
                    else {
                        return String(cString: inet_ntoa(si.sin_addr), encoding: .ascii)
                    }
                }
                
                let sa = addr.withMemoryRebound(to: sockaddr.self, capacity: 1) { $0.pointee }
                addr = addr.advanced(by: Int(sa.sa_len))
            }
            
            rt = rt.advanced(by: Int(msg.rtm_msglen))
        }
        
        return nil
    }
    
    var connectedToWifi: Bool {
        wifiIpAddress != nil
    }
    
    var connectedToCellular: Bool {
        cellularIpAddress != nil
    }
    
}

extension SystemServices {
    
    private func getIpAddress(_ networkInterface: SystemServices.NetworkInterface) -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return address }
        guard let firstAddr = ifaddr else { return address }
        
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ptr.pointee
            let addrFamily = interface.ifa_addr.pointee.sa_family
            
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                let name: String = String(cString: interface.ifa_name)
                if  name == networkInterface.rawValue {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        return address
    }
    
}
