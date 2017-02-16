//
//  TSMainTabBarViewController.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/1/19.
//  Copyright © 2017年 syf. All rights reserved.
//

import UIKit

class TSMainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        tabBar.tintColor = UIColor.brown
        
         let home = TSHomeViewController()
        addChildVC(vc:home , title: "首页", img: "tabbar_home")

        let userCenter = TSUserCenterViewController()
        addChildVC(vc: userCenter, title: "本地我", img: "tabbar_profile")
        
    }
    
    
    // 添加子控件
    private func addChildVC(vc: FDBaseViewController, title:String, img: String){
       
//        let ns : String = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
//        let vcClass : AnyClass? = NSClassFromString(ns + "." + vcNmae)
//        let cls = vcClass as! UIViewController.Type
//        let vc = cls.init()
        
        vc.title = title
        vc.tabBarItem.image = UIImage(named: img)
        vc.tabBarItem.selectedImage = UIImage(named: img + "_highlighted")
        let nav =  FDNavigationController(rootViewController: vc)
        
        addChildViewController(nav)
    }
    


}
