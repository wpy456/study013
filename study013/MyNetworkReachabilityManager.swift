//
//  MyNetworkReachabilityManager.swift
//  study013
//
//  Created by PeiYu Wang on 2019/8/5.
//  Copyright © 2019 PeiYu Wang. All rights reserved.
//

import UIKit
import Alamofire

class MyNetworkReachabilityManager {
    private static let sharedInstance=MyNetworkReachabilityManager()
    var manager=NetworkReachabilityManager(host: "www.baidu.com")
    
    init() {
        manager?.listener={
            status in
            print("网路状态改变：\(status)")
        }
        manager?.startListening()
    }
    class var sharedManager: MyNetworkReachabilityManager {
        let instance=self.sharedInstance
        return instance
    }
    func networkReachabilityStatus()->NetworkReachabilityManager.NetworkReachabilityStatus{
        let status:NetworkReachabilityManager.NetworkReachabilityStatus=(manager?.networkReachabilityStatus)!
        print("当前网络状态：\(status)")
        return status

    }
}
