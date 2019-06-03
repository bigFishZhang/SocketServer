//
//  ServerManager.swift
//  SocketServerApp
//
//  Created by bigfish on 2019/5/20.
//  Copyright © 2019 zzb. All rights reserved.
//

import UIKit

class ServerManager: NSObject {
   fileprivate lazy var serverSocket = TCPServer(addr: "172.18.220.163", port: 7999)
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
      
        DispatchQueue.global().async {
            while self.isServerRunning {
                if let client = self.serverSocket.accept(){
                    DispatchQueue.global().async {
                        print("accept connect")
                        self.handleClient(client)
                    }
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
        
        mgr.delegate = self
        
        clientManagers.append(mgr)
        
        //2 开始接收消息
        mgr.startReadMsg();
        
    }
}


extension ServerManager : ClientManagerDelegate{
    func sendMsgToClient(_ data: Data) {
        for mgr in clientManagers {
            if mgr.tcpClient.send(data: data).0{
                print("转发消息成功")
            }else{
                print("转发消息失败")
            }
        }
    }
}


