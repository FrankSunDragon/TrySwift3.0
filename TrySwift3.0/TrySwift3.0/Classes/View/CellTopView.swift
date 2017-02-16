//
//  CellTopView.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/2/13.
//  Copyright © 2017年 syf. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class CellTopView: UIView {

    var tatus : Status?{
        didSet{
            
            if let status = tatus{
                sourceLabel.text = tatus?.text
                //设置头像
                // set title
                let user = status.user
                
                iconIMg.sd_setImage(with: user.user_url, placeholderImage: UIImage(named: "avatar_default_big"))
                nameLabel.text = user.screen_name
                
                timeLab.text = status.ts_created_at
                timeLab.sizeToFit()
                
                sourceLabel.text = status.sourcex
                //print("xxxxxxxxxx------\(status.source)")
                sourceLabel.sizeToFit()
            }
        }
    }
    
    
  
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private  func setUpUI(){
        addSubview(iconIMg)
        addSubview(verifiedView)
        addSubview(nameLabel)
        addSubview(vipView)
        addSubview(timeLab)
        addSubview(sourceLabel)
        
        let width =  50.0 ; let padding = 10
        iconIMg.snp.makeConstraints { (make) in
            make.width.height.equalTo(width)
            make.left.top.equalTo(padding)
        }
        
        verifiedView.snp.makeConstraints { (make) in
            make.width.height.equalTo(14)
            make.centerX.equalTo(iconIMg).offset(width * 0.35)
            make.centerY.equalTo(iconIMg).offset(width * 0.35)

        }
        
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconIMg.snp.right).offset(10)
            make.top.equalTo(iconIMg)
           // make.width.equalTo(2)
            make.height.equalTo(15)
        }

        vipView.snp.makeConstraints { (make) in
            make.width.height.equalTo(14)
            make.top.equalTo(iconIMg)
            make.left.equalTo(nameLabel.snp.right).offset(8)

        }
        
        timeLab.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
           // make.width.equalTo(2)
            make.height.equalTo(13)

            
        }
        
        sourceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(timeLab.snp.right).offset(8)
            make.top.equalTo(timeLab)
            //make.width.equalTo(200)
            make.height.equalTo(13)
            
        }

    }
    
    
    /**
     *  头像
     */
    private lazy var iconIMg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "avatar_default_big"))
        img.layer.cornerRadius = 25
        img.layer.masksToBounds = true
        return img
    }()
    
    /// 认证图标
    private lazy var verifiedView: UIImageView = UIImageView(image: UIImage(named: "avatar_enterprise_vip"))
    
    /// 昵称
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor =  UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    
    /**
     *  会员标志
     */
    private lazy var vipView: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
    
    // 时间
    private lazy var timeLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.darkGray
        lab.font = UIFont.systemFont(ofSize: 12)
        return lab
    }()
    
    
    /// 来源
    private lazy var sourceLabel: UILabel =
        {
            let label = UILabel()
            label.textColor = UIColor.darkGray
            label.font = UIFont.systemFont(ofSize: 12)
            return label
    }()

    
    
}
