//
//  VerificationsVC.swift
//  RegistrationApp
//
//  Created by comp on 27.11.22.
//

import UIKit

final class VerificationsVC: UIViewController {
    // MARK: Internal

    var userModel: UserModel?
    let randomInt = Int.random(in: 100000 ... 999999)
    var sleepTime = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startKeyboardObserver()
        hideKeyboardWhenTappedAround()
    }

   
// MARK: - Objc func - s
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
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

    // MARK: IBOutlet - s

    @IBOutlet private var infoLbl: UILabel!
    @IBOutlet private var codeTF: UITextField!
    @IBOutlet private var errorCodeLbl: UILabel!
    @IBOutlet private var scrollConstraint: NSLayoutConstraint!

    @IBAction private func codeTFAction(_ sender: UITextField) {
        errorCodeLbl.isHidden = true
        guard let text = sender.text,
              !text.isEmpty, text == randomInt.description
        else {
            errorCodeLbl.text = "Error code. Plese wait \(sleepTime) seconds"
            sender.isUserInteractionEnabled = false
            errorCodeLbl.isHidden = false
            let dispatchAfter = DispatchTimeInterval.seconds(sleepTime)
            let deadline = DispatchTime.now() + dispatchAfter
            DispatchQueue.main.asyncAfter(deadline: deadline) {
                sender.isUserInteractionEnabled = true
                self.errorCodeLbl.isHidden = true
                self.sleepTime *= 2
            }
            return
        }
        performSegue(withIdentifier: "goToWelcomeVC", sender: nil)
    }

    private func setupUI() {
        infoLbl.text = "Please enter code \(randomInt) from \(userModel?.email ?? "")"
    }

//    // MARK: - Scroll keyboard

    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }


// MARK: - Navigation

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? WelcomeVC else { return }
        destVC.userModel = userModel
    }
}
