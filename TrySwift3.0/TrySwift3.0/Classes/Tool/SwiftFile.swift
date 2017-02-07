//
//  SwiftFile.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/1/19.
//  Copyright © 2017年 syf. All rights reserved.
//

import Foundation
import UIKit

// 选择根视图控制器的通知
let SwitchWindowRootViewController = NSNotification.Name(rawValue: "dsaflksadflkjas")
// 跳转到广告页面详情
let  PushAdDetailController  =  NSNotification.Name(rawValue: "pushADDetail")


let SCREEN_WITH = UIScreen.main.bounds.size.width

let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let ADInfoDictKey = "ADInfoDictKey"


func TSColor(x: Float , y : Float , z:Float) -> UIColor{
    
    return  UIColor(colorLiteralRed: Float(x)/255.0, green: Float(y)/255.0, blue: Float(z)/255.0, alpha: 1.0)
};

func TSColor_a(x: Float , y : Float , z:Float, h:Float) -> UIColor{
    
    return  UIColor(colorLiteralRed: Float(x)/255.0, green: Float(y)/255.0, blue: Float(z)/255.0, alpha: Float(h))
};
