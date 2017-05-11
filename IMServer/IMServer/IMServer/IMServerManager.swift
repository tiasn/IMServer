//
//  IMServerManager.swift
//  IMServer
//
//  Created by LTX on 2017/5/9.
//  Copyright © 2017年 LTX. All rights reserved.
//

import Cocoa

class IMServerManager: NSObject {

    fileprivate lazy var serverSocket : TCPServer = TCPServer(address : "0.0.0.0", port : 8585)
    fileprivate lazy var isRunning : Bool = false
}


extension IMServerManager{

    // 开启服务
    func startRunning() {
        
        isRunning = true
        
        print("server is started")

        //1. 监听
        serverSocket.listen()
        
        //2. 开始等待接收客户端的连接
        DispatchQueue.global().async {
            
            while self.isRunning {
                let tcpClient = self.serverSocket.accept()
                
                print("receive a client connection")
                
                // 第一次读取长度
                let lengthBytes = (tcpClient?.read(4))!
                let data = Data(bytes: lengthBytes, count: 4)
                var length : Int = 0
                (data as NSData).getBytes(&length, length: 4)
                
                //第二次读取数据
                let dataBytes = (tcpClient?.read(length))!
                let dataString = String(bytes: dataBytes, encoding: .utf8)!
                print(dataString)
                
                
                
                
                
            }
        }
    }
    
    
    
    func stopRunning() {
        
        isRunning = false

        serverSocket.close()
    }
    
}
