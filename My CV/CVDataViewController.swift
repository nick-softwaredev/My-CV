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
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var dataObject = CVModel()
    var experienceObject: [Int: [ExperienceModel]]?
    
    var index = 0
    
    let backgroundImageArray = ["","",""]
    let segues = ["", ""]
    
    var currentView = UIView()
    var isUnloaded = true
   
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.image = UIImage(named: "back")
        // Do any additional setup after loading the view.
//        var vcID = ""
//
//        backgroundImage.image = UIImage(named: "back")
//        switch dataObject.contentType {
//        case .descriptive: vcID = "CVDescriptiveView"
//        if let customView = Bundle.main.loadNibNamed(vcID, owner: self, options: nil)?.first as? CVDescriptiveView {
//            customView.setup(with: dataObject)
//            currentView = customView
//            view.addSubview(customView)
//            }
//        case .contact: vcID = "CVContactView"
//        if let customView = Bundle.main.loadNibNamed(vcID, owner: self, options: nil)?.first as? CVContactView {
//            currentView = customView
//                   view.addSubview(customView)
//            }
//        case .intercative: vcID = "CVInteractiveView"
//        if let customView = Bundle.main.loadNibNamed(vcID, owner: self, options: nil)?.first as? CVInteractiveView, let _experienceObject = experienceObject {
//            currentView = customView
//            customView.setup(with: _experienceObject)
//            view.addSubview(customView)
//            }
//        }
        //setup view func
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard isUnloaded == true else { return }
        
        var vcID = ""
        
        
        switch dataObject.contentType {
        case .descriptive: vcID = "CVDescriptiveView"
        if let customView = Bundle.main.loadNibNamed(vcID, owner: self, options: nil)?.first as? CVDescriptiveView {
            customView.setup(with: dataObject)
            currentView = customView
            currentView.tag = dataObject.pageIndex
            view.addSubview(customView)
            isUnloaded = false
            print("Loaded De")
            }
        case .contact: vcID = "CVContactView"
        if let customView = Bundle.main.loadNibNamed(vcID, owner: self, options: nil)?.first as? CVContactView {
            currentView = customView
            currentView.tag = dataObject.pageIndex
            view.addSubview(customView)
            isUnloaded = false
            print("Loaded Co \(currentView)")
            }
        case .intercative: vcID = "CVInteractiveView"
        if let customView = Bundle.main.loadNibNamed(vcID, owner: self, options: nil)?.first as? CVInteractiveView, let _experienceObject = experienceObject {
            currentView = customView
            currentView.tag = dataObject.pageIndex
            customView.setup(with: _experienceObject)
            view.addSubview(customView)
            isUnloaded = false
            print("Loaded In \(currentView)")
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _view = currentView as? CVDescriptiveView, _view.tag == 1 {
            _view.animate()
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        currentView.removeFromSuperview()
        print("Unloaded \(currentView)")
        isUnloaded = true
    }
    
}
