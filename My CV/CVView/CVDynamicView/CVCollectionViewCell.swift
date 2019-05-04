//
//  CVCollectionViewCell.swift
//  My CV
//
//  Created by Nick Nick  on 4/29/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import UIKit

class CVCollectionViewCell: UICollectionViewCell {

    var imageTapped: (()->())?
    
    private let cellBackgroundImageView = UIImageView()

    override func layoutSubviews() {
        layer.cornerRadius = 10
        setupBackgroundImage()
    }
    override func awakeFromNib() {
        setupBackgroundImage()
    }
    
    //Mark: Setup cell backgroundImage manually to get properly sized image.
    private func setupBackgroundImage() {
        let gesture = UITapGestureRecognizer(target: self, action:#selector(hadleTap))
        cellBackgroundImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        cellBackgroundImageView.isUserInteractionEnabled = true
        cellBackgroundImageView.addGestureRecognizer(gesture)
        addSubview(cellBackgroundImageView)
    }
    
    func setupCell(_ imageName: String) {
       cellBackgroundImageView.image = UIImage(named: imageName)
        
    }
    
    @objc private func hadleTap() {
        imageTapped?()
    }
    
}
