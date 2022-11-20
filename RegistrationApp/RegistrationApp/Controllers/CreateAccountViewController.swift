//
//  CreateAccountViewController.swift
//  RegistrationApp
//
//  Created by Danya Dankou on 17.11.22.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    // MARK: - Life cicle-s
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - IBAction-s
    @IBAction func emailTFAction(_ sender: UITextField) {
        if let email = sender.text,
           !email.isEmpty,
           VerificationService.isValidEmail(email: email) {
            isValidEmail = true
        } else {
            isValidEmail = false
        }
        errorEmailLb.isHidden = isValidEmail
    }
    
    @IBAction func passTFAction(_ sender: UITextField) {
        if let passText = sender.text,
           !passText.isEmpty {
            passwordStrength = VerificationService.isValidPassword(pass: passText)
        } else {
            passwordStrength = .veryWeak
        }
        errorPasswordLb.isHidden = passwordStrength != .veryWeak
        setupStrongPassIndicatorsViews()
    }
    
    @IBAction func confPassTFAction(_ sender: UITextField) {
        if let confPassText = sender.text,
           !confPassText.isEmpty,
           let passText = passwordTF.text,
           !passText.isEmpty
        {
            isConfPassword = VerificationService.isPassConfirm(pass1:
                passText,
                pass2:
                confPassText)
        } else {
            isConfPassword = false
        }
        errorConfPass.isHidden = isConfPassword
    }

    @IBAction func signInButtonAction() {
        navigationController?.popToRootViewController(animated: true)
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        nameTF.resignFirstResponder()
    }
    
    @IBAction func continueButtonAction() {
        
    }
    
    // MARK: - Private func-s
    private func updateContinueButtonState () {
        continueButton.isEnabled = isValidEmail && isConfPassword && passwordStrength != .veryWeak
    }
    
    private func setupStrongPassIndicatorsViews() {
            for (index, view) in strongPasswordIndicatorsViews.enumerated() {
                if index <= (passwordStrength.rawValue - 1) {
                    view.alpha = 1
                } else {
                    view.alpha = 0.1
                }
         }
    }
    
    // MARK: - IBOutlets
    /// email
    @IBOutlet private var emailTF:
        UITextField!
    @IBOutlet private var errorEmailLb:
        UILabel!
    /// name
    @IBOutlet private var nameTF:
        UITextField!
    /// password
    @IBOutlet private var passwordTF:
        UITextField!
    @IBOutlet private var errorPasswordLb:
        UILabel!
    /// password indicators
         @IBOutlet var strongPasswordIndicatorsViews: [UIView]!
    /// conf password
    @IBOutlet private var confPassTF:
        UITextField!
    @IBOutlet private var errorConfPass:
        UILabel!
    /// continue button
    @IBOutlet private var continueButton:
        UIButton!
    /// scroll view
    @IBOutlet private var scrollView:
        UIScrollView!
    
    // MARK: - Properties
    private var isValidEmail = false {didSet {updateContinueButtonState() }}
    private var isConfPassword = false {didSet {updateContinueButtonState() }}
    private var passwordStrength: PasswordStrength = .veryWeak {didSet {updateContinueButtonState() }}


// MARK: - scrollView keyboard

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset: UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
}
