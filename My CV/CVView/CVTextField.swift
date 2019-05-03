//
//  CVTextField.swift
//  My CV
//
//  Created by Nick Nick  on 5/3/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import UIKit

class CVTextView: UITextView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .white
        self.alpha = 0.9
        self.layer.cornerRadius = 10
    }

}
