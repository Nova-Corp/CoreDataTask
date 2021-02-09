//
//  ViewController.swift
//  CoreDataTask
//
//  Created by ADMIN on 08/02/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import UIKit
import LBTATools

class SignUpViewController: LBTAFormController {

    let signUpView = SignUpView()
    let inputValidationService = InputValidationService()
    
    
    override func loadView() {
        super.loadView()
        signUpView.setupSignUpFields(vc: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpView.signUpButton.addTarget(self, action: #selector(validateInputFields), for: .touchUpInside)
    }
    
    
    @objc func validateInputFields() {
        
        do {
            let firstName = try inputValidationService.validateFirstName(signUpView.firstNameTextField.text)
            let lastName = try inputValidationService.validateLastName(signUpView.lastNameTextField.text)
            let middleName = try inputValidationService.validateMiddleName(signUpView.middleNameTextField.text)
            let gender = try inputValidationService.validateGender(signUpView.chooseGenderDropDown.selectedItem)
            let email = try inputValidationService.validateEmail(signUpView.emailTextField.text)
            let password = try inputValidationService.validatePassword(signUpView.passwordTextField.text)
            let confirmPassword = try inputValidationService.validateConfirmPassword(password, signUpView.confirmPasswordTextField.text)
            let dateOfBirth = try inputValidationService.validateAge(signUpView.datePicker.date)
            let addressLine1 = try inputValidationService.validateAddress1(signUpView.addressLine1TextField.text)
            let addressLine2 = try inputValidationService.validateAddress2(signUpView.addressLine2TextField.text)
            let city = try inputValidationService.validateCity(signUpView.cityTextField.text)
            let state = try inputValidationService.validateState(signUpView.stateTextField.text)
            let country = try inputValidationService.validateCountry(signUpView.countryTextField.text)
            let zipCode = try inputValidationService.validateZipCode(signUpView.zipCodeTextField.text)

            self.presentAlert(with: "Welcome \(firstName) \(lastName)")
            
        } catch let err {
            self.present(err)
        }
    }
    
    
}

extension SignUpViewController {
    private func present(_ dismissableAlert: UIAlertController) {
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
        dismissableAlert.addAction(dismissAction)
        present(dismissableAlert, animated: true)
    }
    
    func presentAlert(with message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(alert)
    }
    
    func present(_ error: Error) {
        presentAlert(with: error.localizedDescription)
    }
}