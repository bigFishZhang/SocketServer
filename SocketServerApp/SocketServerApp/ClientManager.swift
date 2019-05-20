//
//  ClientManager.swift
//  SocketServerApp
//
//  Created by bigfish on 2019/5/20.
//  Copyright © 2019 zzb. All rights reserved.
//

import UIKit

class ClientManager: NSObject {
    
    var tcpClient : TCPClient
    
    fileprivate var isClientConnected : Bool = false
    
    init(tcpClient:TCPClient){
        self.tcpClient = tcpClient
    }
}


extension ClientManager {
    func startReadMsg(){
        //参数是消息的长度
        isClientConnected = true
        while isClientConnected {
            if let msg = tcpClient.read(6){
                let msgData = Data(bytes: msg, count: 6)
                let msgStr = String(data: msgData, encoding: .utf8)
                print(msgStr ?? "miss msg")
            }else{
                print("客户端断开连接")
                  isClientConnected = false
            }
        }
       
        
    }
}
