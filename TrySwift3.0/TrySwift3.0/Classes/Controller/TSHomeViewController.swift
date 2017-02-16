//
//  TSHomeViewController.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/1/19.
//  Copyright © 2017年 syf. All rights reserved.
//

import UIKit
import HandyJSON
let Identifier = "dsflksdfakfsdlfsa"

class TSHomeViewController: FDBaseViewController, UITableViewDelegate , UITableViewDataSource {

    var tableview : UITableView?
    
    var modelArr  = [Status]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
          //1、注册监听 监听点击广告
         NotificationCenter.default.addObserver(self, selector: #selector(pushAdDetail), name: PushAdDetailController, object: nil)
        
        //2\
        setUpTableView()
        
        self.tableview?.estimatedRowHeight = 80 + 20
        
//        let canletdar = Calendar.current
//        
//        
//        let xxx = canletdar.component(.year, from: Date())
//       
////         var ss = canletdar.date(byAdding: .month, value: 2, to: Date())
////          ss = canletdar.date(byAdding: .day, value: 6, to: ss!)
//        
//        
//          var dateComonent = DateComponents()
//        dateComonent.month = 7
//        dateComonent.hour = 1
//        let xx = canletdar.date(byAdding: dateComonent, to: Date())
//        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestStatusData()
    }
    
    
    // 请求微博数据
    func  requestStatusData(){
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        var dict : [String : Any] = ["count" : "20"];
        dict["since_id"] = String(0)
        dict["access_token"] = TSUserAccount.getUserAcount()!.access_token!
        
        
        FDNetworkRequest.getRequest(VC: self, url: url, params: dict, success: { (result) in
            
            let data = try! JSONSerialization.data(withJSONObject: result["statuses"] ?? [String : AnyObject](), options: .prettyPrinted)
            let strJson =  String.init(data: data, encoding: String.Encoding.utf8)
            let students = JSONDeserializer<Status>.deserializeModelArrayFrom(json: strJson)
            //print("++++++++++++\(students)")
            
            self.modelArr = students! as! [Status]
            self.tableview!.reloadData()

        }) { (error) in
            
        }
        
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
    
    
    func setUpTableView(){
         let tab = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT))
        tab.backgroundColor = UIColor.clear
         tab.dataSource = self
         tab.delegate = self
         tableview = tab
         self.view.addSubview(tab)
        
        tab.register(TSHomeCell.self, forCellReuseIdentifier: Identifier)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.modelArr.count
    }
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableview?.dequeueReusableCell(withIdentifier: Identifier, for: indexPath) as! TSHomeCell
        
        let statusn = self.modelArr[indexPath.row]
        cell.status = statusn
      //  cell.textLabel?.text = statusn.text!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    
}

