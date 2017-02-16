//
//  TSLoginViewController.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/1/19.
//  Copyright © 2017年 syf. All rights reserved.
//

import UIKit
import HandyJSON

class TSLoginViewController: UIViewController {

    let WB_AppKey = "683401259"
    let WB_AppSecret = "a40c2225afd530d1e7eee45434fd1942"
    let WB_Redirect_url = "https://www.baidu.com"
    
    override func loadView() {
        view = UIWebView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "登录"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeVC))
        
        let web : UIWebView = view as! UIWebView
        let oauthStr = "https://api.weibo.com/oauth2/authorize?client_id=\(WB_AppKey)&redirect_uri=\(WB_Redirect_url)"
        let url = URL(string: oauthStr)
        let request = URLRequest(url: url!)
        web.loadRequest(request)
        web.delegate = self
    }
    
    
    func closeVC(){
       // let model = TSUserAccount.getUserAcount()
        dismiss(animated: true, completion: nil)
    }
    
    
    func  getUserData(code : String){
        
        let url = "https://api.weibo.com/oauth2/access_token"
        let dict : [String : Any] = ["client_id" :WB_AppKey,
                                     "client_secret" :WB_AppSecret,
                                     "grant_type" : "authorization_code",
                                     "code" :code,
                                     "redirect_uri" :WB_Redirect_url,];
        
        FDNetworkRequest.postRequest(VC: self, url: url, params: dict, success: { (reslut) in
          print("返回的结果：\(reslut)")
            
            let sutdent = TSUserAccount(dict: reslut)
            sutdent.getUserOtherInfo(resulted: { (model, error) in
          
                if(model != nil){
                model!.saveAcount()
                    // 缓存用户信息成功后，
                    
                 NotificationCenter.default.post(name: SwitchWindowRootViewController, object: "23")
               //  self.closeVC()
            }
            })
        
//            if  let student = JSONDeserializer<TSUserAccount>.deserializeFrom(dict: reslut as NSDictionary?){
//                print(student)
//                
//                //
//            }
            
        }) { (error) in }
      }

}

//MARK: webview的代理方法
extension TSLoginViewController :UIWebViewDelegate{
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
       print("调用了吗")
       print(request.url!.absoluteString)
        
       let urlStr = request.url!.absoluteString
        if urlStr.hasPrefix(WB_Redirect_url){// 用户点击授权
          let codeStr = "code="
            if request.url!.query!.hasPrefix(codeStr){
               let code = request.url!.query!.substring(from: codeStr.endIndex)
                print("\(code)")
                getUserData(code: code)
            }
            else{
               closeVC()
            }
            return false
        }
        
        return true
    }
    
}
