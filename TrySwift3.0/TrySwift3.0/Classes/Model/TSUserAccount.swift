//
//  TSUserAccount.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/1/20.
//  Copyright © 2017年 syf. All rights reserved.
//

import Foundation
import HandyJSON
import UIKit

class TSUserAccount: NSObject, NSCoding {
    
    var access_token : String?
    
    var expires_in: NSNumber? 
 
    var uid: String?
    
    /// 过期的时间
    var expires_Date: NSDate?

    // 用户头像
    var avatar_large : String?
    
    //用户名字
    var screen_name : String?
    

    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        // 防止闪退
    }
    
    //保存账户
     func saveAcount(){
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString
       let path = cachePath.appendingPathComponent("sdfsd.ts")
       let result  =   NSKeyedArchiver.archiveRootObject(self, toFile: path)
         print("归档是否成功\(result)")
        
    }
    
    // 类方法
    class func getUserAcount() ->TSUserAccount?{
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString
        let path = cachePath.appendingPathComponent("sdfsd.ts")
        
        let obj : TSUserAccount? =  NSKeyedUnarchiver.unarchiveObject(withFile: path) as? TSUserAccount
        return obj
    }
    
    // 归档
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_in, forKey: "expires_in")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_Date, forKey: "expires_Date")
        aCoder.encode(avatar_large, forKey: "avatar_large")
        aCoder.encode(screen_name, forKey: "screen_name")
    }

    
    //MARK: - 解档
    required init(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        expires_in = aDecoder.decodeObject(forKey: "expires_in") as? NSNumber
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        expires_Date = aDecoder.decodeObject(forKey: "expires_Date") as? NSDate
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
    }

    
    
    /// 得到用户的详细数据
    func getUserOtherInfo(resulted: @escaping(TSUserAccount?, Error?) -> Void){
        
         let url1 = "https://api.weibo.com/2/users/show.json"
        let dict1 = ["access_token" : self.access_token!, "uid" : self.uid!]
        FDNetworkRequest.getRequest(VC: nil, url: url1, params: dict1, success: { (result) in

            print("返回的结果：\(result)")
             self.screen_name = result["screen_name"] as! String?
            self.avatar_large = result["avatar_large"] as! String?
            
            resulted(self, nil)
            
            
        }, failture: { (error) in
            resulted(nil, error)
        })
        
    }
    
    
    // 判断用户是否登录
    class func isLogin() -> Bool{
    return TSUserAccount.getUserAcount() != nil
    }
    
}







