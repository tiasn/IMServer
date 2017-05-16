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
    
    fileprivate lazy var clients : [IMClientManager] = [IMClientManager]()
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
                guard let tcpClient = self.serverSocket.accept() else{ continue }
                
                self.handle(tcpClient)
                
                print("receive a client connection")

            }
        }
    }
    
    
    
    func stopRunning() {
        
        isRunning = false

        serverSocket.close()
    }
    
}


extension IMServerManager{

    func handle(_ client : TCPClient) {
        let clientMgr = IMClientManager(tcpClient: client)
        clients.append(clientMgr)
        clientMgr.startReadMsg()
    }
    
    
}
