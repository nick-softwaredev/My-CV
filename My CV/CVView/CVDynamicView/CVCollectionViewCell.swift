//
//  CVCollectionViewCell.swift
//  My CV
//
//  Created by Nick Nick  on 4/29/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import UIKit

class CVCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    var imageTapped: (()->())?
    
    let cellBackgroundImageView = UIImageView()
    
    override func awakeFromNib() {
    }

    override func layoutSubviews() {
        
        layer.cornerRadius = 10
        
        let gesture = UITapGestureRecognizer(target: self, action:#selector(hadleTap))
        cellBackgroundImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        cellBackgroundImageView.isUserInteractionEnabled = true
        cellBackgroundImageView.addGestureRecognizer(gesture)
        addSubview(cellBackgroundImageView)
    }
    
    func setupCell(_ image: String) {
       cellBackgroundImageView.image = UIImage(named: image)
        
    }
    @objc func hadleTap() {
        imageTapped?()
    }
    
}
