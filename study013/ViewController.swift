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
//多图上传
    @IBAction func multiUpload(_ sender: AnyObject) {
//        let fileURL1=Bundle.main.url(forResource: "Simulator Screen Shot - iPhone Xʀ - 2019-04-11 at 21.23.54", withExtension: "png")
//        let fileURL2=Bundle.main.url(forResource: "Simulator Screen Shot - iPhone Xʀ - 2019-07-21 at 21.51.00", withExtension: "png")

//AF.upload(
//                multipartFormData: { multipartFormData in
//                    multipartFormData.append(fileURL1!, withName: "unicorn")
//                    multipartFormData.append(fileURL2!, withName: "rainbow")
//            } ,to: "https://httpbin.org/post",
//               encodingCompletion: { encodingResult in
//                switch encodingResult {
//                case .success(let upload, _, _):
//                    upload.responseJSON { response in
//                        debugPrint(response)
//                    }
//                case .failure(let encodingError):
//                    print(encodingError)
//                }
//            }
//        )
    }
    //上传
    @IBAction func upload(_ sender: Any) {
        let fileURL=Bundle.main.url(forResource: "Simulator Screen Shot - iPhone Xʀ - 2019-07-21 at 21.51.00", withExtension: "png")
//        let fileURL=Bundle.main.path(forResource: "Simulator Screen Shot - iPhone Xʀ - 2019-07-21 at 21.51.00", ofType: "png")
        AF.upload(fileURL!,to:"http://www.lia5.com/api")
            .uploadProgress{progress in
                print("完成比例：\(progress.fractionCompleted)")
                print("当前完成：\(progress.completedUnitCount)")
                print("总共大小：\(progress.totalUnitCount)")
                
            }
        .validate()
            .responseJSON{response in
                DispatchQueue.main.async {
                    print("上传结果：\(response.result)")
                    let message="上传结果：\(response.result)"
                    let alert=UIAlertController(title: "信息", message: message, preferredStyle: .alert)
                    let OKAction=UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(OKAction)
                    self.present(alert,animated: true,completion: nil)
                }
        }
    }
    //get post
    @IBAction func touchupInsideGetRequestBtnAction(_ sender: AnyObject) {
        
        AF.request("https://api.nahede.com/api", method: .post ,parameters: ["way": "init","uid":[1,2,3],"did":["x":1,"y":2]])
            .responseJSON {
                response in
                print("original URL request:\(String(describing: response.request))")
                print("URL response:\(String(describing: response.response))")
                print("server data:\(String(describing: response.data))")
                print("result of response serialization:\(response.result)")
                
                
               
                switch response.result {
                    
                case .success(let data):
                    //把得到的JSON数据转为数组
                   
                    
                    if let items =  data as? NSArray{
                        //遍历数组得到每一个字典模型
                        print("dict")
                        for dict in items{
                            print("dict")
                            print("\(dict)")
                        }
                    }else{
                        print(data)
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

