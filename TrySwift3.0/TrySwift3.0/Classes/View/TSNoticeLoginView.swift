//
//  TSNoticeLoginView.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/1/19.
//  Copyright © 2017年 syf. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

// 声明协议
protocol TSNoticeLoginDelegate : NSObjectProtocol{
    func userLoginClick()
}

class TSNoticeLoginView: UIView {
    
    weak var delegate : TSNoticeLoginDelegate?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(loginIMg)
        addSubview(loginBtn)
         createUI()
    }
    
    private func createUI(){
        loginIMg.snp.makeConstraints { (make) in
         make.center.equalTo(self)
         make.width.equalTo(200)
         make.height.equalTo(loginIMg.snp.width).multipliedBy(0.54)
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(loginIMg.snp.bottom).offset(15)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private lazy var loginIMg : UIImageView = {
        let img = UIImageView.init()
        img.sd_setImage(with: URL(string: "https://upload-images.jianshu.io/upload_images/1163208-ca47f7bbe7e5f62c.gif?imageMogr2/auto-orient/strip"))
        return img
    }()
    
    
    private lazy var loginBtn : UIButton = {
    let btn = UIButton(type: .custom)
     btn.setTitle("登录", for: .normal)
    btn.backgroundColor = TSColor(x: 100, y: 57, z: 157)
    btn.titleLabel?.textColor = UIColor.white
        btn.addTarget(self, action: #selector(letUserLogin), for: .touchUpInside)
    return btn
    }()

    
     @objc private func letUserLogin(){
        delegate?.userLoginClick()
    }

    
}


