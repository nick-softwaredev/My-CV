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
    
    //private var index = 0
  //  var titleLabelText = ""
  //  var titleLabelText_ = ""
    var pageData = CVPageModel()
    
    var index: Int {
        get {
            return pageData.pageIndex
        }
    }
    
    var titleLabelText: String {
        get {
            return pageData.title
        }
    }
    
    private let imageArray = ["page1_backgroundImage", "page2_backgroundImage", "page3_backgroundImage", "page4_backgroundImage"]
    
    weak var delegate: CVSetupDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        guard imageArray.count > index else {
            backgroundImageView.backgroundColor = .lightGray
            view.insertSubview(backgroundImageView, at: 0)
            return
        }
        backgroundImageView.image = UIImage(named: imageArray[index])
        backgroundImageView.sendSubviewToBack(view)
        backgroundImageView.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImageView, at: 0)
    }
    
    func setupWith(descpription: String? = nil,profileImageName: String? = nil,experienceData: [Int: [CVExperienceModel]]? = nil ,contactData: CVContactModel? = nil) {
        delegate?.setupWith(descpription: descpription, profileImageName: profileImageName, experienceData: experienceData, contactData: contactData)
    }

}

protocol CVSetupDelegate: class {
    func setupWith(descpription: String?,profileImageName: String?,experienceData: [Int: [CVExperienceModel]]?,contactData: CVContactModel?)
}
