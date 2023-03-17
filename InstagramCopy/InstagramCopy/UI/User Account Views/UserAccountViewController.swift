//
//  UserAccountViewController.swift
//  InstagramCopy
//
//  Created by Sebastian Guiscardo on 3/17/23.
//

import UIKit

class UserAccountViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userPasswordConfirmTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: UserAccountViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserAccountViewModel()
    }
    
    // MARK: - Actions
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = userEmailTextField.text,
              let password = userPasswordTextField.text else { return }
        viewModel.signIn(email: email, password: password)
    }
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        
        guard let email = userEmailTextField.text,
              let password = userPasswordTextField.text,
              let confirmPassword = userPasswordConfirmTextField.text else { return }
        
        viewModel.createAccount(email: email, password: password, confirmPassword: confirmPassword)
    }
    
    @IBAction func guestModeButtonTapped(_ sender: Any) {
        exit(0);
    }
}
