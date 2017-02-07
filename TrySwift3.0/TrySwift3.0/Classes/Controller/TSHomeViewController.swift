//
//  TSHomeViewController.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/1/19.
//  Copyright © 2017年 syf. All rights reserved.
//

import UIKit

class TSHomeViewController: FDBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        NotificationCenter.default.addObserver(self, selector: #selector(pushAdDetail), name: PushAdDetailController, object: nil)
    }
    
    
    func pushAdDetail(notifi: Notification){
        
        if let xxx = notifi.object{
            if xxx is [String : String] {// 如果是字典类型
                let vc = TSDetailAdViewController()
                
                vc.webUrl =  (xxx as! [String : String])["adUrl"]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }

    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
