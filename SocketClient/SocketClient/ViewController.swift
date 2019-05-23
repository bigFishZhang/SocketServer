//
//  ViewController.swift
//  SocketClient
//
//  Created by bigfish on 2019/5/20.
//  Copyright © 2019 zzb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate lazy var socket : ZBSocket  = ZBSocket(addr: "172.18.220.69", port: 7999)

    override func viewDidLoad() {
        super.viewDidLoad()
        if socket.connectServer() {
            print("connectServer")
        }else {
            print("connectServer failed!")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         let msg = "hello zhangdayu..."
         let data = msg.data(using: .utf8)!
        // 1 消息长度写到data
        var length = data.count
        let headData = Data(bytes: &length, count: 4)
        // 2 消息类型
        var tempType = 2
        let typeData = Data(bytes: &tempType, count: 2)
        // 3 发送消息
        let totalData = headData + typeData + data;

        if socket.sendMsg(totalData){
            
            print("send msg success!")
        }else{
            print("send msg failed !")
        }
    }
    
}



