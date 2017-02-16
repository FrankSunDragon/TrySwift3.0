//
//  Status.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/2/7.
//  Copyright © 2017年 syf. All rights reserved.
//

import UIKit
import HandyJSON

class Status: HandyJSON {

    /// 微博ID
    var id: Int = 0

    /// 微博信息内容
    var text: String?
    
    //配图数组
    var pic_urls: [[String: AnyObject]]?
    

    // 插图的缩略图
    var chatu_small_url : [URL]?{
        var arrs = [URL]()
        if let arr = pic_urls{
            for dict in arr{
                if let imgStr = dict["thumbnail_pic"] as? String{
                     arrs.append(URL(string: imgStr)!)
                }
            }
            return arrs
        }
        return nil
    }
    
    
    // 插图的原图
    var chatu_large_url : [URL]?{
        var arrs = [URL]()
        if let arr = pic_urls{
            for dict in arr{
                if let imgStr = dict["thumbnail_pic"] as? String{
                    let largeImgStr = imgStr.replacingOccurrences(of: "thumbnail_pic", with: "large")

                    arrs.append(URL(string: largeImgStr)!)
                }
            }
            return arrs
        }
        return nil
    }
    
    
    // 发布来源
    var source: String?{
        didSet{
            if let sourcex = source{
                
                if sourcex == ""{
                    return
                }
                
                let location = (sourcex as NSString).range(of: ">").location + 1
                let  length = (sourcex as NSString).range(of: "<", options: .backwards).location - location
            
                source = "来自" + (sourcex as NSString).substring(with: NSMakeRange(location, length))
                    
            }
                
        }
    }
    
    var sourcex: String{
        if let sourcex = source{
            
            if sourcex == ""{
                return ""
            }
            
            let location = (sourcex as NSString).range(of: ">").location + 1
            let  length = (sourcex as NSString).range(of: "<", options: .backwards).location - location
            
             return "来自" + (sourcex as NSString).substring(with: NSMakeRange(location, length))
            
        }
        
        return ""

    }
    

    
    // 发布时间
    var created_at: String?
    
    var ts_created_at: String?{
        let date =  Date.dateConvertByStr(str: created_at!)
        return date.dealWithDate
    }
    
    

    
    
    // 用户信息
    var user = TSUser()
    
    required init(){}

    
}
