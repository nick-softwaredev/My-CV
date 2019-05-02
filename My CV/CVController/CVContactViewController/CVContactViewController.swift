//
//  CVContactViewController.swift
//  My CV
//
//  Created by Nick Nick  on 5/1/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import UIKit

class CVContactViewController: CVDataViewController, CVSetupDelegate {
    
    @IBOutlet weak var questionTwoLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionOneLabel: UILabel!
    
    private let contactAlert = UIAlertController(title: "Contact", message: "Which way would you like to\n contact me?", preferredStyle: .actionSheet)
    private let feedbackAlert = UIAlertController(title: "Feedback", message: "Leave your feedback", preferredStyle: .alert)
    
    @IBAction func contactButton(_ sender: Any) {
        present(contactAlert, animated: true, completion: nil)
    }
    
    @IBAction func feedbackButton(_ sender: Any) {
        present(feedbackAlert, animated: true, completion: nil)
    }
    
    private var contactModel: CVContactModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleLabelText
        questionOneLabel.text = "Want to invite me to an interview?\nFeel free to press that button."
        questionTwoLabel.text = ""
        
        setupContactAlert()
        setupFeedbackAlert()
        // Do any additional setup after loading the view.
    }
    
    override func setupWith(descpription: String? = nil,profileImageName: String? = nil,experienceData: [Int: [CVExperienceModel]]? = nil ,contactData: CVContactModel? = nil) {
        contactModel = contactData
    }
    
    private func setupContactAlert() {
        let callAction = UIAlertAction(title: "Phone call", style: .default) { [unowned self] (_) in
            guard let phoneURL = URL(string: "telprompt://\(self.contactModel?.phoneNumber ?? "")") else {
                return
            }
            if UIApplication.shared.canOpenURL(phoneURL){
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(phoneURL as URL)
                }
            }
        }
        let emailAction = UIAlertAction(title: "Email", style: .default) { [unowned self] (_) in
            guard let url = URL(string: "mailto:\(self.contactModel?.email ?? "")") else {
                return
            }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        let dissmiss = UIAlertAction(title: "Cancel", style: .cancel) { [unowned self](_) in
            self.contactAlert.dismiss(animated: true, completion: nil)
        }
        contactAlert.addAction(callAction)
        contactAlert.addAction(emailAction)
        contactAlert.addAction(dissmiss)
    }
    
    private func setupFeedbackAlert() {
        feedbackAlert.addTextField() { [unowned self] newTextField in
            newTextField.placeholder = "Type something..."
            newTextField.delegate = self
        }
        feedbackAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        feedbackAlert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            if let textFields = self.feedbackAlert.textFields, let textField = textFields.first, let result = textField.text {
                print(result)
            }
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparaprofileImageNametion before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CVContactViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 40
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
