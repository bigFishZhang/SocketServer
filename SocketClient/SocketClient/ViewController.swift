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


}

