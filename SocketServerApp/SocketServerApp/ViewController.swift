//
//  ViewController.swift
//  SocketServerApp
//
//  Created by bigfish on 2019/5/20.
//  Copyright © 2019 zzb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate lazy var serverMgr :ServerManager = ServerManager()
 
    @IBOutlet weak var serverStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func startServerClick(_ sender: UIButton) {
        serverMgr.startRunning()
        serverStatusLabel.text = "服务已启动ing"
    }
    
    @IBAction func stopServerClick(_ sender: Any) {
        serverMgr.stopRunning()
        serverStatusLabel.text = "服务已关闭"
    }

}

