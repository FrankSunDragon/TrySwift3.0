//
//  TSDetailAdViewController.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/2/2.
//  Copyright © 2017年 syf. All rights reserved.
//

import UIKit

class TSDetailAdViewController: FDBaseViewController {

    override func loadView() {
        view = web
    }
    
    var webUrl : String?{
        didSet{
          let url = URL(string: webUrl!)
          web.loadRequest(URLRequest(url: url!))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FD_NavigationBarWithTitle(titlee: "广告详情")
        
    }

    
    private lazy var web :  UIWebView = {
       let web = UIWebView(frame: UIScreen.main.bounds)
        return web
    }()
    
    
    // 重写父类的方法
    override func BackBtnClick() {
    self.navigationController!.popViewController(animated: true)

    }
}
