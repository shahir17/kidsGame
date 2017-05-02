//
//  MemoryCollectionViewCell.swift
//  Kid Joy Center
//
//  Created by Shahir Abdul-Satar on 3/22/17.
//  Copyright © 2017 Ahmad Shahir Abdul-Satar. All rights reserved.
//

import UIKit

class MemoryCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    var frontImage: UIImage!
    var backImage: UIImage!
    override init(frame: CGRect) {
        
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        super.init(frame: frame)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(imageView)
        
        
        
}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
