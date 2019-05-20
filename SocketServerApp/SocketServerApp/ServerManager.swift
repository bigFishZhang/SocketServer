//
//  ServerManager.swift
//  SocketServerApp
//
//  Created by bigfish on 2019/5/20.
//  Copyright © 2019 zzb. All rights reserved.
//

import UIKit

class ServerManager: NSObject {
   fileprivate lazy var serverSocket = TCPServer(addr: "172.18.220.69", port: 7999)
}
extension ServerManager {
    
    func startRunning(){
        if serverSocket.listen().0 {
            print("listen success!")
        }else{
            print("listen failed!")
            return
        }
        while true {
            DispatchQueue.global().async {
                if let client =  self.serverSocket.accept(){
                    print("accept connect")
                }
                
            }
        }
        
        
    }
    
    func stopRunning(){
        
    }
    
    
    
}
