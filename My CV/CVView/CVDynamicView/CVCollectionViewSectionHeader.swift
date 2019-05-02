//
//  CVCOllectionViewSectionHeader.swift
//  My CV
//
//  Created by Nick Nick  on 4/29/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import Foundation
import UIKit

class CVCollectionViewSectionHeader: UICollectionReusableView {
    @IBOutlet weak var sectionHeaderlabel: UILabel!
    
    func setup(_ index: Int) {
        switch index {
        case 0:
            sectionHeaderlabel.text = "Work Experience"
        case 1:
            sectionHeaderlabel.text = "Certificates"
        case 2:
            sectionHeaderlabel.text = "Self Education"
        default:
            sectionHeaderlabel.text = "Section Name"
        }
    }
}
