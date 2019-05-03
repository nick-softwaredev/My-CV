//
//  CVButton.swift
//  My CV
//
//  Created by Nick Nick  on 5/3/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import UIKit

class CVButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.5, alpha: 1)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        self.setTitleColor(.white, for: .normal)
        self.layer.borderWidth = 2
        self.layer.borderColor  = UIColor.white.cgColor
        self.layer.cornerRadius = 10
    }
}
