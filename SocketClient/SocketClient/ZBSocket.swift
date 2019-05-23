//
//  ZBSocket.swift
//  SocketClient
//
//  Created by bigfish on 2019/5/20.
//  Copyright © 2019 zzb. All rights reserved.
//

import UIKit

class ZBSocket: NSObject {
    fileprivate  var tcpClient : TCPClient
    init(addr: String, port: Int){
       tcpClient = TCPClient(addr: addr, port: port)
    }
}

extension ZBSocket {
    func connectServer() -> Bool {
        return tcpClient.connect(timeout: 5).0
    }
}

extension ZBSocket {
    func sendMsg(_ msg : Data) -> Bool {
        return tcpClient.send(data: msg).0
    }
}
