//
//  SYFCLASS.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/2/2.
//  Copyright © 2017年 syf. All rights reserved.
//

import Foundation
import UIKit

class SYFCLASS {
    
    class func SYFNEWBarButton(imageStr : String, isPianyi : Bool ) ->UIButton{
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btn.adjustsImageWhenHighlighted = false
        btn.setImage(UIImage(named: imageStr), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: -13, left: -30, bottom: -13, right: 0)
        return btn
    }
    
  
}
