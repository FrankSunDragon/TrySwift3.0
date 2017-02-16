//
//  FDBaseViewController.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/1/18.
//  Copyright © 2017年 syf. All rights reserved.
//

import UIKit

class FDBaseViewController: UIViewController, TSNoticeLoginDelegate {

    override func loadView() {
        if TSUserAccount.isLogin(){//已登录
            super.loadView()
        }
        else{
            view = webview
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = TSColor(x: 224, y: 224, z: 224)
    }

    
    private lazy var webview : TSNoticeLoginView = {
       let web = TSNoticeLoginView(frame: UIScreen.main.bounds)
        web.delegate = self
         return web
    }()
    
    
    /// 代理方法
    func userLoginClick() {
    print("执行登录操作")
    let nav = UINavigationController(rootViewController: TSLoginViewController())
    present(nav, animated: true, completion: nil)
    
    }
    
    
    func FD_NavigationBarWithTitle(titlee : String){
        title = titlee
        let btn = SYFCLASS.SYFNEWBarButton(imageStr: "icon_back", isPianyi: true)
        btn.addTarget(self, action: #selector(BackBtnClick), for: .touchDown)
        let backItem = UIBarButtonItem(customView: btn)
        navigationItem.leftBarButtonItem = backItem
    }
    
  
      func BackBtnClick(){
        
//        if let nav = self.navigationController{
//            nav.popViewController(animated: true)
//        }
//        else{
//            dismiss(animated: true, completion: nil)
//        }
        
        if  self.responds(to: #selector(UIViewController.dismiss(animated:completion:))){
          dismiss(animated: true, completion: nil)
        }
        else{
            self.navigationController!.popViewController(animated: true)
        }
    }
    


}
