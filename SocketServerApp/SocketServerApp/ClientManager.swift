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
            if let lMsg = tcpClient.read(4){
                // 1 读取数据长度
                let headData = Data(bytes: lMsg, count: 4)
                var length : Int = 0
                (headData as NSData).getBytes(&length, length: 4)
                
                // 2 读取类型
                guard let typeMsg = tcpClient.read(2) else {
                    print("read type failed!")
                    return;
                }
                let typeData = Data(bytes: typeMsg, count: 2)
                var type : Int = 0
                (typeData as NSData).getBytes(&type, length: 2)
                print(type)
                
                // 3 读取消息
                guard let msg = tcpClient.read(length) else {
                    print("read msg failed!")
                    return;
                }
                let msgData = Data(bytes: msg, count: length)
                
                switch type {
                case 0,1:
                    let user = try! UserInfo.parseFrom(data: msgData)
                    print(user.name)
                default:
                    print("未知类型")
                }
                
                //let msgStr = String(data: msgData, encoding: .utf8)
                //print(msgStr ?? "miss msg")
                
            }else{
                print("客户端断开连接")
                isClientConnected = false
                
            }
        }
       
        
    }
}
