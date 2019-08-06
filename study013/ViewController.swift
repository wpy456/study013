//
//  ViewController.swift
//  study013
//
//  Created by PeiYu Wang on 2019/8/5.
//  Copyright © 2019 PeiYu Wang. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func touchupInsideGetRequestBtnAction(_ sender: AnyObject) {
        
        AF.request("https://api.jietuqi.cn/api", method: .get ,parameters: ["foo": "bar"])
            .responseJSON {response in
//                print("\(response.result)")
                switch response.result {
                case .success(let data):
                    //把得到的JSON数据转为数组
                    print(data)
                    if let items =  data as? NSArray{
                        //遍历数组得到每一个字典模型
                        for dict in items{
                            print(dict)
                        }
                    }
                case .failure( let error):
                    print("error:::\(error)")
                }
        }
    }
    
    @IBAction func touchupInsideCheckBtnAction(sender:UIButton){
    
        var message="当前无网络"
        let status:NetworkReachabilityManager.NetworkReachabilityStatus=MyNetworkReachabilityManager.sharedManager.networkReachabilityStatus()
        
        switch status {
        case .notReachable:
            message="当前无网络"
            print(message)
            break
        case .reachable(NetworkReachabilityManager.ConnectionType.ethernetOrWiFi):
            message="是WIFI网路"
            print(message)
            break
        case .reachable(NetworkReachabilityManager.ConnectionType.wwan):
            message="是移动网络"
            print(message)
            break
        default:
            message="当时无网络"
            break
        }
        
        let alert=UIAlertController(title: "信息", message: message, preferredStyle: .alert)
        let OKAction=UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(OKAction)
        self.present(alert,animated:true,completion:  nil)

        /*
        //let _:[String:String]=MyNetworkReachabilityManager.sharedManager.get(url: "https://api.jietuqi.cn/api", param: ["way" : "init"])
        Alamofire.Request("https://api.jietuqi.cn/api", .get , ["way":"init"]).responsejson{ response in
            if let JSON=response.result.value{
                print("JSON:\(JSON)")
            }
        }
 */
    }

}

