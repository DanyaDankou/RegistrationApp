//
//  ProfileVC.swift
//  RegistrationApp
//
//  Created by comp on 27.11.22.
//


import UIKit

class ProfileVC: UIViewController {
    
    @IBAction func logOutAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func deleteAccountAction() {
        UserDefaultsService.cleanUserDefaults()
        navigationController?.popToRootViewController(animated: true)
    }
}

