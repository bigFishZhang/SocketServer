//
//  ViewController.swift
//  SocketClient
//
//  Created by bigfish on 2019/5/20.
//  Copyright © 2019 zzb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate lazy var socket : ZBSocket  = ZBSocket(addr: "172.18.220.94", port: 7999)

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
//         let msg = "hello zhangdayu..."
//         let data = msg.data(using: .utf8)!
//         var length = data.count
        
//        let dict : [String : Any] = ["name":"zzb","message":"hello zzb","userlevel":10]
//        let data = JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let userInfo = UserInfo.Builder()
        userInfo.name = "zzb\(arc4random_uniform(10))"
        userInfo.level = 20
        let msgData = (try! userInfo.build()).data()
        var length =  msgData.count 
        
        
         // 1 消息长度写到data
        let headData = Data(bytes: &length, count: 4)
        
        
        // 2 消息类型
        var tempType = 1
        let typeData = Data(bytes: &tempType, count: 2)
        // 3 发送消息
        let totalData = headData + typeData + msgData;

        if socket.sendMsg(totalData){
            
            print("send msg success!")
        }else{
            print("send msg failed !")
        }
    }
    
}



