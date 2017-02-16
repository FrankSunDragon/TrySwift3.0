//
//  FDNavigationController.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/1/19.
//  Copyright © 2017年 syf. All rights reserved.
//

import UIKit

class FDNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.viewControllers.count > 0{
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
        
    }


}
