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
    
    // Mark: Defining properties that are used by all children contollers.
    var pageData = CVPageModel()
    
    final var index: Int {
        get {
            return pageData.pageIndex
        }
    }
    
    final var titleLabelText: String {
        get {
            return pageData.title
        }
    }
    
    final var currentBackgroundImage: UIImage? {
        get {
            return backgroundImageView.image
        }
    }
    
    //Mark: Defining class properties
    private let imageArray = ["page1_backgroundImage", "page2_backgroundImage", "page3_backgroundImage", "page4_backgroundImage"]
    
    var numberOfPages = 0
    
    private weak var delegate: CVSetupDelegate?

    private var pageControl =  UIPageControl()
    private var backgroundImageView  = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupViewBackground()
        configurePageControl()
    }
    
    private func setupViewBackground() {
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        backgroundImageView.image = UIImage(named: imageArray[getImageFor(pageIndex: index)])
        backgroundImageView.sendSubviewToBack(view)
        backgroundImageView.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImageView, at: 0)
    }
    
    private func configurePageControl() {
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = index
        pageControl.tintColor = .black
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .gray
        pageControl.isUserInteractionEnabled = false
        view.addSubview(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        pageControl.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 16).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -16).isActive = true
    }
    
    // Function return index of imageName stored in array
    private func getImageFor(pageIndex pageIndex_: Int) -> Int{
        if pageIndex_ < imageArray.count {
            return pageIndex_
        }
        return getImageFor(pageIndex: pageIndex_ - imageArray.count)
    }
    
    func setupWith(description: String? = nil,profileImageName: String? = nil,experienceData: [Int: [CVExperienceModel]]? = nil ,contactData: CVContactModel? = nil) {
        delegate?.setupWith(description: description, profileImageName: profileImageName, experienceData: experienceData, contactData: contactData)
    }

}

protocol CVSetupDelegate: class {
    ///This function is required to setup view with infromation from the pageModel object, each child overrides with its providies required parameters to fucntion properly.
    ///
    /// - Parameter description: optional String that contains description (CVPalinController required).
    ///  - Parameter profileImageName: optional String with profile image name (CVPlainController required).
    /// - Parameter  experienceData: optinal dictionary that contains Int(section number) as key and [CVExperienceModel] as value (CVDynamicController required).
    ///  - Parameter contactData: optinal CVContactModel (CVContactController required).
    func setupWith(description: String?,profileImageName: String?,experienceData: [Int: [CVExperienceModel]]?,contactData: CVContactModel?)
}
