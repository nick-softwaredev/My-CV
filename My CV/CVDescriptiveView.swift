//
//  CVDescriptiveView.swift
//  My CV
//
//  Created by Nick Nick  on 4/28/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import UIKit

class CVDescriptiveView: UIView {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        //imageHeightConstraint.constant = 120
//        guard let _ = profileImageView.image else {
//            self.profileImageView.isHidden = true
//            self.imageHeightConstraint.constant = 0
//            self.layoutIfNeeded()
//            return
//        }
    }
    
    func animate() {
        guard let _ = profileImageView.image else {
        DispatchQueue.main.async {
            self.imageHeightConstraint.constant = 0
            UIView.animate(withDuration: 1) { [weak self] in
                self?.profileImageView.alpha = 0
                self?.superview?.layoutIfNeeded()
            }
        }
        return
        }
    }
    
    func setup(with data: CVModel) {
        titleView.text = data.title
        descriptionTextView.text = data.description
        imageHeightConstraint.constant = 120
        imageHeightConstraint.isActive = true
        profileImageView.image = UIImage(named: data.imageTitle)
    }
}
