//
//  ViewController.swift
//  IMServer
//
//  Created by LTX on 2017/5/9.
//  Copyright © 2017年 LTX. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  
    @IBOutlet weak var statusLable: NSTextField!
    
    fileprivate lazy var mgr : IMServerManager = IMServerManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func startRunning(_ sender: NSButton) {
        statusLable.stringValue = "服务器已启动！"
        mgr.startRunning()
    }
    

    @IBAction func stopRunning(_ sender: NSButton) {
        statusLable.stringValue = "服务器已停止！"
        mgr.stopRunning()
    }


  
    
}

