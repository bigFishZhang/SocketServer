//
//  ClientManager.swift
//  SocketServerApp
//
//  Created by bigfish on 2019/5/20.
//  Copyright © 2019 zzb. All rights reserved.
//

import UIKit

protocol ClientManagerDelegate:class {
    func sendMsgToClient(_ data:Data)
    func removeClient(_ client:ClientManager)
}

class ClientManager: NSObject {
    weak var delegate:ClientManagerDelegate?
    
    var tcpClient : TCPClient
    
    fileprivate var isClientConnected : Bool = false
    
    fileprivate var heartTimeCount : Int = 0
    
    init(tcpClient:TCPClient){
        self.tcpClient = tcpClient
    }
}


extension ClientManager {
    func startReadMsg(){
        //参数是消息的长度
        isClientConnected = true
        
        let timer = Timer(fireAt: Date(), interval: 1, target: self, selector: #selector(checkHeartBeat), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode:.commonModes)
        timer.fire()
        
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
                
                //如果是离开房间消息 就从系统移除
                if type == 1{
                    tcpClient.close()
                    delegate?.removeClient(self)
                }else if type == 100{
                    heartTimeCount = 0
                    let msg = String(data: msgData, encoding: .utf8)
                    print(msg ?? "")
                    continue
                }
                
                //发送消息
                let totalData = headData + typeData + msgData
                delegate?.sendMsgToClient(totalData)
                

            }else{
                self.removeClient()
            }
        }
        
    }
    
    
    @objc fileprivate func checkHeartBeat() {
        heartTimeCount += 1
        if heartTimeCount >= 10 {
            self.removeClient()
        }
    }
    
    
    private func removeClient(){
        delegate?.removeClient(self)
        isClientConnected = false
        print("客户端断开了连接")
        tcpClient.close()
    }
    
    
    
    
}
