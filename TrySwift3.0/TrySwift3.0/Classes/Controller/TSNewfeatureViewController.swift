//
//  TSNewfeatureViewController.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/1/18.
//  Copyright © 2017年 syf. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TSNewfeatureViewController: UICollectionViewController {

    private let pageCount = 4
    
    private var layout = NewfeatrueLayout()
  
    
    // 初始化方法
    init() {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        // Register cell classes
        self.collectionView!.register(NewfeatrueCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }



    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewfeatrueCell
       cell.imageIndex = indexPath.row
        weak var ddddd : UICollectionView? = collectionView
        cell.imgBlock = { index in
            ddddd!.setContentOffset( CGPoint(x: UIScreen.main.bounds.size.width * (CGFloat(index) + 1), y: 0)
, animated: false)
        }
        return cell
    }
}

// 自定义的collectioncell
private class NewfeatrueCell : UICollectionViewCell{
    
    // 传进来的只是
     var imageIndex : Int?{
        didSet{
            self.img.image = UIImage(named:"new_feature_\(imageIndex! + 1)")
        }
 }
   
     var imgBlock:((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(self.img)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 懒加载
    private lazy var img : UIImageView = {
        var img = UIImageView()
        img.frame = self.bounds
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nextResbonder)))
        return img
    }()
    
    
    func nextResbonder(){
        print("点击图片啊")
        if(imageIndex == 3){// 跳出去
     
      NotificationCenter.default.post(name: SwitchWindowRootViewController, object: "收到了吗")
            
            
        }else{//下一页
            if((imgBlock) != nil){
                imgBlock!(imageIndex!)
            }
        }
    }
}

private class NewfeatrueLayout : UICollectionViewFlowLayout{
    
 

    
    override func prepare(){
        // 准备布局
        itemSize = UIScreen.main.bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        
        scrollDirection = .horizontal
        
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false
        collectionView?.isPagingEnabled = true
        
        
    }
}
