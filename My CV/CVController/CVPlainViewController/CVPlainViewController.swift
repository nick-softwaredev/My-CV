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
    @IBOutlet weak var descriptionLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleLabelText
        descriptionLabel.text = descriptionText
        profileImage.image = UIImage(named: profileImageString)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if index == 1 {
            profileImageHeightConstraint.constant = 120
            profileImage.alpha = 1
            
        } else if index == 0 {
            profileImageHeightConstraint.constant = 0
            profileImage.alpha = 0
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
    override func setupWith(descpription: String? = nil,profileImageName: String? = nil,experienceData: [Int: [CVExperienceModel]]? = nil ,contactData: CVContactModel? = nil) {
        descriptionText = descpription ?? ""
        profileImageString = profileImageName ?? ""
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
