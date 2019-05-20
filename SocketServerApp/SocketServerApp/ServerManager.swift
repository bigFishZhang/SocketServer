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
   fileprivate var  isServerRunning : Bool = false
    fileprivate lazy var clientManagers : [ClientManager] = [ClientManager]()
}
extension ServerManager {
    
    func startRunning(){
        //1 开启监听
        if serverSocket.listen().0 {
            print("listen success!")
            isServerRunning = true
        }else{
            print("listen failed!")
            return
        }
        //2 开始接收连接
        while isServerRunning {
            DispatchQueue.global().async {
                if let client =  self.serverSocket.accept(){
                    print("accept connect")
                    self.handleClient(client)
                }
                
            }
        }
        
        
    }
    
    func stopRunning(){
        isServerRunning = false
    }
    
}

extension ServerManager {
    fileprivate func handleClient(_ client : TCPClient){
        //1 保存
        let mgr = ClientManager(tcpClient: client)
        clientManagers.append(mgr)
        
        //2 开始接收消息
        mgr.startReadMsg();
        
    }
}



