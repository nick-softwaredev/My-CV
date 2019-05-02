//
//  CVCollectionDetailViewController.swift
//  My CV
//
//  Created by Nick Nick  on 5/1/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import UIKit

class CVCollectionDetailViewController: UIViewController,  UITextFieldDelegate{

    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailNameLabel: UILabel!
    
    var detailName = ""
    var detailDescription = ""
    
    @IBAction func doneAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         detailNameLabel.text = detailName
         detailTextView.text = detailDescription
    }
}

