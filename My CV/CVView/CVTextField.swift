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
        self.isEditable = false
        self.showsHorizontalScrollIndicator = false
        self.isSelectable = true
        self.isScrollEnabled = true
        self.alpha = 0.85
        self.layer.cornerRadius = 10
        self.textAlignment = .natural
        self.font = UIFont.systemFont(ofSize: 17, weight: .light)
        self.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

}

extension String {
    //used to format description propertie of CVPageModel and CVexperienceModel.
    func splitOnLines() -> String {
        let formattedText = self.components(separatedBy: ". ").joined(separator: ".\n\n").components(separatedBy: ": ").joined(separator: ":\n\n")
        return formattedText
    }
}
