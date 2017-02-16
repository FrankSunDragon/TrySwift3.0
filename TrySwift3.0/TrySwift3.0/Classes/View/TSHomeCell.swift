//
//  TSHomeCell.swift
//  TrySwift3.0
//
//  Created by Jacky Sun on 2017/2/13.
//  Copyright © 2017年 syf. All rights reserved.
//

import UIKit
import SnapKit

let padding = 10
class TSHomeCell: UITableViewCell {

    
    var  status : Status?{
        didSet{
            topView.tatus = status
            // 正文
            contentLabel.text = status?.text
            contentLabel.sizeToFit()
            
            pictureView.status = status
            let tuple =  pictureView.calculateImageSize()
            let pictureSize = tuple.viewSize
            //  print("---------------\(pictureSize)")
            let offset = pictureSize.height == 0 ? 0 : 10
             pictureView.snp.updateConstraints { (make) in
                make.top.equalTo(contentLabel.snp.bottom).offset(offset)
                make.width.equalTo(pictureSize.width)
                make.height.equalTo(pictureSize.height)
            }
//
//           pictureView.reloadData()
        }
    }
    
    
  override  init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
     addSubview(topView)
     addSubview(contentLabel)
     addSubview(pictureView)
    
     topView.snp.makeConstraints { (make) in
        make.left.top.right.equalTo(0)
        make.height.equalTo(60)
    }
    
    contentLabel.snp.makeConstraints { (make) in
        make.top.equalTo(topView.snp.bottom).offset(padding)
        make.left.equalTo(padding)
        make.right.equalTo(-padding)
        
    }
    
    
    pictureView.snp.makeConstraints { (make) in
      make.top.equalTo(contentLabel.snp.bottom).offset(padding)
        make.left.equalTo(10)
        make.width.equalTo(0)
        make.height.equalTo(0)
        make.bottom.equalTo(-padding)
    }
    
    }
    
    // 返回cell的高度
    func cellHeight(status : Status) ->CGFloat{
        self.status = status
        self.layoutIfNeeded()
        
        return pictureView.frame.maxY + CGFloat(padding)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    private lazy var topView : CellTopView = CellTopView(frame: CGRect())

    
    /// 正文
    lazy var contentLabel: UILabel =
        {
            let label = UILabel()
            label.textColor = UIColor.darkGray
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 15)
          //  label.sizeToFit()
          //  label.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20
            return label
    }()
    
    
    // 插图
    lazy var pictureView : TSPictureView = TSPictureView()
}
