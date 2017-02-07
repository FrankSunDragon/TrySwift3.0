
//  AppDelegate.swift
//  TrySwift3.0
//  Created by Jacky Sun on 2017/1/18.
//  Copyright © 2017年 syf. All rights reserved.
//

import UIKit
import SDWebImage

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
     

            window = UIWindow(frame: UIScreen.main.bounds)
            window?.makeKeyAndVisible()
            window?.rootViewController = TSMainTabBarViewController()
            //TSNewfeatureViewController()
        
        // 1 设置导航栏外观
         setupNavigationBar()
        
        //2 开始注册监听
        NotificationCenter.default.addObserver(self, selector: #selector(receiveChangeRootVC), name:SwitchWindowRootViewController, object: nil)
        
       // getFilePathByImgName(name: "sdfsd")
        
        //3 请求最新的广告页面
       dealWithAdPage()
        
        return true
    }
    

    func receiveChangeRootVC(notifi: Notification){
        print(notifi.object!)
        
        if let xxx = notifi.object{
            if xxx is [String : String] {// 如果是字典类型
            let vc = TSDetailAdViewController()
            
            
            vc.webUrl =  (xxx as! [String : String])["adUrl"]
            let nav = UINavigationController(rootViewController: vc)
            window?.rootViewController  = nav
            }
            else{
                window?.rootViewController  = TSMainTabBarViewController()
            }

        }
            }

    
    func setupNavigationBar(){
        
        let nav = UINavigationBar.appearance()
        nav.titleTextAttributes = {[
            NSForegroundColorAttributeName : UIColor.brown,
            NSFontAttributeName : UIFont.systemFont(ofSize: 17.0)
        ]}();
        
        let textAttributes : [String : Any]? = {[
            NSForegroundColorAttributeName : UIColor.purple,
            NSFontAttributeName : UIFont.systemFont(ofSize: 17.0)
        ]}()
    
        UIBarButtonItem.appearance().setTitleTextAttributes(textAttributes!, for: .normal)
    }
    
    
    // 根据图片名字得到全路径
    func getFilePathByImgName(name: String) ->String{
     let path  =  NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last! as NSString
        return path.appendingPathComponent(name)
    }
    
    // 判断沙河里面指定路径是否有先关文件
    func adjustCachesHaveFilePath(filePath : String) ->Bool{
        
        let fullPath = getFilePathByImgName(name: filePath)
       return  FileManager.default.isExecutableFile(atPath: fullPath)
    }
    
    
    // 处理广告页面这一业务逻辑
    func dealWithAdPage(){
        // 从沙河里面看能不能去取出广告页面， 
        let  goalDict =  UserDefaults.standard.dictionary(forKey: ADInfoDictKey)
        if let dict = goalDict{//
            //3、添加广告页
            let adView = TSAppAdView(frame: UIScreen.main.bounds)
            adView.infoDict = dict as? [String : String]
            adView.show()
        }
        
        // 得到新的广告数据
        getNewAdData()
    }
    
    // 获取最新的广告数据
    func getNewAdData(){
        // 1\ 模拟判断网络
        let status = FDNetworkRequest.isReachable()
        if(status == false){
          return
        }
        
        let urlArr : [[String : String]] = [
              ["imgUrl":"https://p1.pstatp.com/large/16370003df0115740cb4" ,"adUrl" : "https://github.com/ashleymills/Reachability.swift"],
             ["imgUrl":"https://p3.pstatp.com/large/6905/4218196026" ,"adUrl" : "https://github.com/ashleymills/Reachability.swift"],
            ["imgUrl":"https://p2.pstatp.com/large/5356/4939459436" ,"adUrl" : "https://github.com/ashleymills/Reachability.swift"],
             ["imgUrl":"https://p3.pstatp.com/origin/11110002bc6f1a44f33e" ,"adUrl" : "https://github.com/ashleymills/Reachability.swift"],
              ["imgUrl":"https://p3.pstatp.com/large/32e0004bfba511fede1" ,"adUrl" : "https://github.com/ashleymills/Reachability.swift"],
               ["imgUrl":"https://p9.pstatp.com/large/4b400024b7791bca51e" ,"adUrl" : "https://github.com/ashleymills/Reachability.swift"],
            ["imgUrl":"https://p1.pstatp.com/origin/153a0002842015fd4192" ,"adUrl" : "https://github.com/ashleymills/Reachability.swift"],
            ["imgUrl":"https://p1.pstatp.com/origin/1630000051031cbe1f8d" ,"adUrl" : "https://github.com/ashleymills/Reachability.swift"],
            ["imgUrl":"https://p1.pstatp.com/origin/1537000407e089476866" ,"adUrl" : "https://github.com/ashleymills/Reachability.swift"],
            ["imgUrl":"https://p1.pstatp.com/origin/1537000407e089476866" ,"adUrl" : "https://github.com/ashleymills/Reachability.swift"],
            ["imgUrl":"https://p2.pstatp.com/origin/15390007b2281fdfa19e" ,"adUrl" : "https://github.com/ashleymills/Reachability.swift"]
        ]
        
        let random = Int(arc4random()) % urlArr.count // 产生一个随机数
        let dict : [String : String] = urlArr[random]
        if let value = dict["imgUrl"]{// 后台返回有数据
            
        // 判断沙河里面是否有这个文件
          let  goalDict =  UserDefaults.standard.dictionary(forKey: ADInfoDictKey)
           
          let imgUrl = goalDict?["imgUrl"] as? String
        
            if goalDict == nil || imgUrl != value{
                
                downloadAdImgUrl(imgurl: value, result: { (isfinish) in
                if isfinish == true{
                    //移除上一次缓存
                    if let dddd = imgUrl
                    {
                     SDImageCache.shared().removeImage(forKey: dddd, fromDisk: true)
                    }

                UserDefaults.standard.set(dict, forKey: ADInfoDictKey)
                UserDefaults.standard.synchronize()
                }})

            }
        }
     }
    
    // 下载图片， 缓存图片
    func downloadAdImgUrl(imgurl : String ,  result : @escaping((isFinish : Bool)) -> ()){
        let url : URL = URL(string: imgurl)!
        SDWebImageManager.shared().downloadImage(with: url, options: .retryFailed, progress: { (_, _) in
        }) { (image, error, _, finished, url) in
            result(finished)
        }
    }
 }

