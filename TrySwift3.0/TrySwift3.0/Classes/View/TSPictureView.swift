//
//  TSPictureView.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/2/16.
//  Copyright © 2017年 syf. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

private let distance : CGFloat = 5


private let Idddd = "sdlkfjlskdfjl"
class TSPictureView: UICollectionView {
    
    // 获取数据
    var status : Status?
    {
        didSet{
            reloadData()
        }
    }

    init() {
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
       // 注册cell
        delegate = self
         dataSource = self
        self.register(pictureCell.self, forCellWithReuseIdentifier: Idddd)
        
        backgroundColor = UIColor.white
        isScrollEnabled = false
        layout.minimumLineSpacing = CGFloat(distance)
        layout.minimumInteritemSpacing = CGFloat(distance)
        layout.scrollDirection = .vertical
     //   layout.itemSize = CGSize(width: 100, height: 100)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - 计算插图的大小和 item的size
    func calculateImageSize() ->(viewSize: CGSize, itmeSize: CGSize) {
        
        if let arr = status!.chatu_small_url{
            if arr.count == 0{
              //  layout.itemSize = CGSize.zero
                return (CGSize.zero, CGSize.zero)

            }
            let itemWidth = (SCREEN_WITH - 2 * 10 - 2 * distance) / 3.0
            
            if arr.count == 1{// 一张图片
                layout.itemSize = CGSize(width: 100, height: 100)
                return (CGSize(width: 100, height: 100), CGSize(width: 100, height: 100))
                
            }
            else if arr.count == 4{
                let viewWidth = itemWidth * 2 + distance * 1
                layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
                return (CGSize(width: viewWidth, height: viewWidth), CGSize(width: itemWidth, height: itemWidth))
            }
            else{
                //一共有多少行
                let hang = (arr.count - 1) / 3 + 1
                let viewWidth = arr.count < 3 ? (distance + itemWidth) * CGFloat(arr.count) - distance * CGFloat(arr.count - 1)  : (SCREEN_WITH - 20)
                  let viewHeight = (distance + itemWidth) * CGFloat(hang) - distance * CGFloat(arr.count - 1)
                
                layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
                return (CGSize(width: viewWidth, height: viewHeight), CGSize(width: itemWidth, height: itemWidth))

            }
            
        }
       // layout.itemSize = CGSize.zero
        return (CGSize.zero, CGSize.zero)
    }

    
    // 布局
    var layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    
}

class pictureCell: UICollectionViewCell {
    
    var imgUlr : URL?{
        didSet{
        picImg.sd_setImage(with: imgUlr)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(picImg)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var picImg : UIImageView = {
    let img =  UIImageView(frame: self.bounds)
    img.contentMode = .scaleAspectFill
    img.clipsToBounds = true
    return img
    }()
    
}


extension TSPictureView : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return status?.chatu_small_url?.count ?? 0
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Idddd, for: indexPath) as! pictureCell
        cell.imgUlr = status?.chatu_small_url?[indexPath.row]
        return cell
    }
    
}



