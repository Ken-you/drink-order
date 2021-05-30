//
//  AdCollectionViewCell1.swift
//  drink-order
//
//  Created by yousun on 2021/5/25.
//

import UIKit

// 輪播廣告的 CollectionView Cell 元件設定
class AdCollectionViewCell: UICollectionViewCell {
    
    var imageView = UIImageView()
        
    func setupImageView() {
        
        imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 200)
        
        imageView.backgroundColor = .lightGray
        
        self.addSubview(imageView)
    }
      
    override func layoutSubviews() {
        
        setupImageView()
    }
}
