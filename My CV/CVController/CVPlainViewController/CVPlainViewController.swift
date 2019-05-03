//
//  CVPlainViewController.swift
//  My CV
//
//  Created by Nick Nick  on 5/1/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import UIKit

class CVPlainViewController: CVDataViewController, CVSetupDelegate {
    
    private var descriptionText = ""
    private var profileImageString = ""
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleLabelText
        descriptionTextView.text = descriptionText.splitOnLines()
        profileImage.image = UIImage(named: profileImageString)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard index <= 1 else {
            profileImageHeightConstraint.constant = 0
            return
        }
        prepareForImageTransition()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard index <= 1 else {
            return
        }
        animateImageTransition()
    }
    
    // Prepares to animate image appereance and dissappearance for fisrt and second page (index) accordingly.
    private func prepareForImageTransition() {
        if index == 1 {
            profileImageHeightConstraint.constant = 120
            profileImage.alpha = 1
            
        } else if index == 0 {
            profileImageHeightConstraint.constant = 0
            profileImage.alpha = 0
        }
    }
    // Animates image appereance and dissappearance for fisrt and second page (index) accordingly.
    private func animateImageTransition() {
        if index == 1 {
            DispatchQueue.main.async {
                self.profileImageHeightConstraint.constant = 0
                UIView.animate(withDuration: 1) { [weak self] in
                    self?.profileImage.alpha = 0
                    self?.view?.layoutIfNeeded()
                }
            }
            return
        }
        else if index == 0 {
            DispatchQueue.main.async {
                self.profileImageHeightConstraint.constant = 120
                UIView.animate(withDuration: 1) { [weak self] in
                    self?.profileImage.alpha = 1
                    self?.view?.layoutIfNeeded()
                }
            }
            return
        }
    }
    
    
    override func setupWith(description: String? = nil,profileImageName: String? = nil,experienceData: [Int: [CVExperienceModel]]? = nil ,contactData: CVContactModel? = nil) {
        descriptionText = description ?? ""
        profileImageString = profileImageName ?? ""
    }

}
