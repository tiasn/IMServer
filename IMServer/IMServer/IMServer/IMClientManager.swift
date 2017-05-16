//
//  IMClientManager.swift
//  IMServer
//
//  Created by LTX on 2017/5/11.
//  Copyright © 2017年 LTX. All rights reserved.
//

import Cocoa

class IMClientManager: NSObject {
    
    var tcpClient : TCPClient
    var isReadMsg :Bool = false
    
    
    init(tcpClient : TCPClient){
        
        self.tcpClient = tcpClient
    }
    
}


extension IMClientManager{
    
    func startReadMsg() {
        
        isReadMsg = true
        
        while isReadMsg {
            
            if let lengthBytes = tcpClient.read(4){
            
                // 第一次读取长度
                let data = Data(bytes: lengthBytes, count: 4)
                var length : Int = 0
                (data as NSData).getBytes(&length, length: 4)
                
                //第二次读取数据
                guard let dataBytes = tcpClient.read(length)else{
                    continue
                }
                
                let dataString = String(bytes: dataBytes, encoding: .utf8)!
                print(dataString)
                

                
            }else{
                print("客户端主动断开了链接。。。")
            }
        }
    }
    
}
