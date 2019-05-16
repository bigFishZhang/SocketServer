//
//  ViewController.swift
//  SocketServer
//
//  Created by bigfish on 2019/5/16.
//  Copyright © 2019 zzb. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var hintLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func startServerClick(_ sender: NSButton) {
        hintLabel.stringValue = "服务器已经开启"
        
    }
    

    @IBAction func stopServerClick(_ sender: NSButton) {
        hintLabel.stringValue = "服务器未开启"
    }
    
    
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

