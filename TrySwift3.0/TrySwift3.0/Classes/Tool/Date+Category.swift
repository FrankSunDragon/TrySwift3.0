//
//  Date+Category.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/2/15.
//  Copyright © 2017年 syf. All rights reserved.
//

import UIKit


extension Date{
    
    var dealWithDate: String{
            let canlendar =  Calendar.current
            let formatter = DateFormatter()

        if(canlendar.isDateInToday(self)){ // 今天
         let timeInterval = Date().timeIntervalSince(self)
            if timeInterval < 60{
                return "刚刚"
            }
            else if timeInterval < 3600{
               return "\(Int(timeInterval/60))分钟前"
            }
            else{
                return "\(Int(timeInterval/3600))小时前"
            }
           
        }
            
        else if(canlendar.isDateInYesterday(self)){// 昨天
              formatter.dateFormat = "昨天 HH:mm"
               return formatter.string(from: self)
        }
        let dateComponents = canlendar.dateComponents([Calendar.Component.year], from: self, to: Date())
         if dateComponents.year! < 1{// 小于1年
            formatter.dateFormat = "MM月dd日"
            return formatter.string(from: self)

        }
            return "一年一前"

    }

    
    static func dateConvertByStr(str : String) -> Date{
        
        let formatter : DateFormatter = DateFormatter()
      //  formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z yyy"

        formatter.locale = Locale(identifier: "cn")
        let dd =  formatter.date(from: str)
        return  dd!
    }
    
    
    
    
}
