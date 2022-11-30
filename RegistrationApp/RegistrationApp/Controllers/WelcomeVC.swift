//
//  WelcomeVC.swift
//  RegistrationApp
//
//  Created by comp on 27.11.22.
//

import UIKit

class WelcomeVC: UIViewController {
    
    // MARK: Internal

    var userModel: UserModel?

    @IBOutlet var infoLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    @IBAction func saveUserDateAndContinueAction() {
        guard let userModel = userModel else { return }
        UserDefaultsService.saveUserModel(userModel: userModel)
        navigationController?.popToRootViewController(animated: true)
    }

    // MARK: Private

    private func setupUI() {
        infoLbl.text = "\(userModel?.name ?? "") to cool app"
    }
}
