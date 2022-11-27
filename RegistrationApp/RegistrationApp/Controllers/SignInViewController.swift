//
//  SignInViewController.swift
//  RegistrationApp
//
//  Created by comp on 17.11.22.
//

import UIKit

class SignInViewController: UIViewController {
    // MARK: Internal

    @IBOutlet var scrollConstraint: NSLayoutConstraint!

    @IBOutlet var emailTF: UITextField!

    @IBOutlet var errorLbl: UILabel!
    @IBOutlet var passTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
        if let _ = UserDefaultsService.getUserModel() {
            performSegue(withIdentifier: "goToMainTBVC", sender: nil)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        emailTF.text = ""
        passTF.text = ""
    }

    @IBAction func singInAction() {
        errorLbl.isHidden = true
        guard let email = emailTF.text,
              let password = passTF.text,
              let userModel = UserDefaultsService.getUserModel(),
              email == userModel.email,
              password == userModel.pass
        else {
            errorLbl.isHidden = false
            return
        }
        performSegue(withIdentifier: "goToMainTBVC", sender: nil)
    }


    // MARK: - Scroll keyboard

    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height / 2
            }
        }

    }

    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height / 2
            }
        }
    }
}
