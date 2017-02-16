//
//  TSUser.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/2/14.
//  Copyright © 2017年 syf. All rights reserved.
//

import UIKit
import HandyJSON

class TSUser: HandyJSON {

    /// 用户ID
    var id: Int = 0
    
    var screen_name : String?
    
    /// 用户头像地址（中图），50×50像素
    var profile_image_url: String?
      
    
    
    var user_url : URL?{
        get{
            if let urlStr = profile_image_url{
               return  URL(string: urlStr)
            }
             return nil
         }
    }
    
    
    var location : String?
    required init(){}
    
    
}
