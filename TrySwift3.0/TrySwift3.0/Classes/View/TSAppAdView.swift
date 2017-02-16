//
//  TSAppAdView.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/1/22.
//  Copyright © 2017年 syf. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

class TSAppAdView: UIView {

    var count : Int = 4
    
    // 传进来的广告数据
    var  infoDict : [String : String]?{
        didSet{
        let adImgurl = infoDict!["imgUrl"]
        let url = URL(string: adImgurl!)
        let key =  SDWebImageManager.shared().cacheKey(for: url)
        let img = SDImageCache.shared().imageFromDiskCache(forKey: key)
        adImg.image = img
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
         self.backgroundColor = UIColor.purple
         addSubview(backImg)
         addSubview(adImg)
         addSubview(coutBtn)
        
        coutBtn.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.top.equalTo(30)
            make.right.equalTo(-20)
        }
     
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // 添加到window
    func show(){
        UIApplication.shared.keyWindow!.addSubview(self)
          RunLoop.main.add(timer, forMode: .commonModes)
    }
    

    private lazy var backImg : UIImageView = {
        let dss = TSAppAdView.getBackIMg()
        let img = UIImageView(frame: UIScreen.main.bounds)
          img.backgroundColor = UIColor.red
        if let xxx = dss{
            img.image =  UIImage(named: xxx)
        }
        return img
    }()
    
    
    
    private lazy var adImg : UIImageView = {
       let img = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT - 120))
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushAdWebPage)))
        img.backgroundColor = UIColor.red
        return img
    }()
    
    
    private lazy var timer : Timer = {
        let timer = Timer(fireAt: Date(), interval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        return timer
    }()
    
    
    private lazy  var coutBtn : UIButton = {
         let btn = UIButton(type: UIButtonType.custom)
         btn.backgroundColor = TSColor_a(x: 0, y: 0, z: 0, h:0.6)
         btn.setTitle("跳过", for: UIControlState.normal)
         btn.setTitleColor(UIColor.white, for: UIControlState.normal)
         btn.addTarget(self, action: #selector(skipBtnClick), for: .touchDown)
         btn.layer.cornerRadius = 3
         btn.clipsToBounds = true
        return btn
    }()
    
    
    func countDown(){
      //  print("调用计时器了吗")
        count -= 1
        if count == 0{ // 计算时间完成
            dismiss()
            
        }
    }
    
    // 移除广告页面
    func dismiss(){
        

       timer.invalidate()
       
        UIView.animate(withDuration: 0.6) {
           self.removeFromSuperview()
            
        }
    }

    
    class private func getBackIMg() ->String?{
        let  screenSize =  UIScreen.main.bounds.size
        let  orientation = "Portrait" // 横屏请设置成 @"Landscape"
        var launchImage : String?
        
        let images : [[String : Any]] = Bundle.main.infoDictionary!["UILaunchImages"] as!  [[String : Any]]
        
        for var dict in images{
            let imgsize : CGSize = CGSizeFromString(dict["UILaunchImageSize"] as! String)
            
            if __CGSizeEqualToSize(screenSize, imgsize) && orientation == (dict["UILaunchImageOrientation"] as! String){
                launchImage = dict["UILaunchImageName"] as? String;
                
            }
        }
        return launchImage
    }
    
    // 点击挑过的响应事件
    func skipBtnClick() {
        print("点击达到就离开房间辣是")
        dismiss()

    }
    
    
    // 点击广告 跳转到广告页面
    func pushAdWebPage(){
        NotificationCenter.default.post(name: PushAdDetailController, object: infoDict!)

      //  dismiss()
   //  NotificationCenter.default.post(name: SwitchWindowRootViewController, object: infoDict!)
    }
    
}
