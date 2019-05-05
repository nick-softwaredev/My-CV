//
//  CVContactViewController.swift
//  My CV
//
//  Created by Nick Nick  on 5/1/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import UIKit
import MessageUI

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
        questionTwoLabel.text = "Am I not good enough?\nLet me know how to get better."
        
        setupContactAlert()
        setupFeedbackAlert()
    }
    
    override func setupWith(description: String? = nil,profileImageName: String? = nil,experienceData: [Int: [CVExperienceModel]]? = nil ,contactData: CVContactModel? = nil) {
        contactModel = contactData
        print("\(self) was setup")
    }
    
    private func setupContactAlert() {
        let callAction = UIAlertAction(title: "Phone call", style: .default) { [unowned self] (_) in
            guard let phoneURL = URL(string: "tel://\(self.contactModel?.phoneNumber?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "") ?? "")"), UIApplication.shared.canOpenURL(phoneURL) else {
                return
            }
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }
        let emailAction = UIAlertAction(title: "Email", style: .default) { [unowned self] (_) in
            guard let url = URL(string: "mailto:\(self.contactModel?.email ?? "")"), UIApplication.shared.canOpenURL(url)  else {
                return
            }
                UIApplication.shared.open(url)
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
        feedbackAlert.addAction(UIAlertAction(title: "Proceed", style: .default) { [unowned self] action in
            if let textFields = self.feedbackAlert.textFields, let textField = textFields.first, let result = textField.text {
                 self.sendEmail(to: self.contactModel?.email ?? "", withMessage: result)
            }
        })
    }

}

//Mark: UITextFieldDelegateUI

extension CVContactViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 40
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}

// Mark: - MFMailComposeViewControllerDelegate
extension CVContactViewController: MFMailComposeViewControllerDelegate {
    func sendEmail(to recipient: String, withMessage message: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([recipient])
            mail.setMessageBody("\(message)", isHTML: false)
            
            present(mail, animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "Sorry, an error occured:(", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
