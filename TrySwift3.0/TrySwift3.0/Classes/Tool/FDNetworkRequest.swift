//
//  FDNetworkRequest.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/1/19.
//  Copyright © 2017年 syf. All rights reserved.
//

import Foundation
import Alamofire
import ReachabilitySwift


class FDNetworkRequest {
    
    ///get请求
    class func getRequest(VC:UIViewController?, url: String, params : [String : Any],  success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()) {
        
        //使用Alamofire进行网络请求时，调用该方法的参数都是通过getRequest(urlString， params, success :, failture :）传入的，而success传入的其实是一个接受           [String : AnyObject]类型 返回void类型的函数
        
        Alamofire.request(url, method: HTTPMethod.get, parameters: params)
            .responseJSON { (response) in/*这里使用了闭包*/
                //当请求后response是我们自定义的，这个变量用于接受服务器响应的信息
                //使用switch判断请求是否成功，也就是response的result
                switch response.result{
                case .success:
                    //当响应成功是，使用临时变量value接受服务器返回的信息并判断是否为[String: AnyObject]类型 如果是那么将其传给其定义方法中的success
                        if let value = response.result.value as? [String: AnyObject] {
                         success(value)
                        }
                    
                case .failure( _):
                    print("请求失败——————————")
                    failture(response.result.error!)
                }
        }
    }
    
    
    
    // post 请求
    //MARK: - POST 请求
  class func postRequest(VC : UIViewController?, url : String, params : [String : Any], success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()) {
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: params).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value as? [String: AnyObject] {
                    success(value)
                }
            case .failure( _):
                print("请求失败——————————")

                failture(response.result.error!)
            }
            
        }
    }
    
    
    
    // 检测网络状态
    class func isReachable() -> Bool{
    
       let reachability = Reachability.init()
        return reachability!.isReachable
        
    }
}
