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
    @IBOutlet weak var detailBackgroundImage: UIImageView!
    
    var detailName = ""
    var detailDescription = ""
    var link: URL?
    var backgroundImage: UIImage?
    
    @IBAction func doneAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var actionButton: CVButton!
    
    @IBAction func showAction(_ sender: Any) {
        if let appStoreLink = link {
            UIApplication.shared.open(appStoreLink, options: [:], completionHandler: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         detailNameLabel.text = detailName
         detailTextView.text = detailDescription
         detailBackgroundImage.blurImage()
         detailBackgroundImage.image = backgroundImage
        
         doneButton.layer.cornerRadius = actionButton.layer.cornerRadius
         actionButton.isHidden = link == nil
    }
}

fileprivate extension UIImageView{
    func blurImage()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}
