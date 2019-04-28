//
//  CVDataViewController.swift
//  My CV
//
//  Created by Nick Nick  on 4/28/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import Foundation

import UIKit

class CVDataViewController: UIViewController {
    
    var dataObject = CVModel()
    
    let backgroundImageArray = ["","",""]
    let segues = ["", ""]
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          self.titleLabel!.text = dataObject.title
          self.profileImage.image = UIImage(named: dataObject.imageTitle)
          self.descriptionTextView.text = dataObject.description
          self.actionButton.titleLabel?.text = dataObject.buttonTitle
        
          backgroundImage.image = UIImage(named: "backround")
        
          view.addSubview(loadView())
    }

    func loadView() -> UIView {
        //switch contentType {}
        let view = UIView()
        view.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        view.backgroundColor = .white
        return view
    }
    
    
}
