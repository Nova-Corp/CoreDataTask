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
        signUpView.setupSignUpView(vc: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpView.signUpButton.addTarget(self, action: #selector(validateInputFields), for: .touchUpInside)
        signUpView.addUserDetailsButton.addTarget(self, action: #selector(didTapAddUserButton), for: .touchUpInside)
        signUpView.viewUserDetailsButton.addTarget(self, action: #selector(didTapViewUserButton), for: .touchUpInside)
    }
    
    @objc func didTapViewUserButton() {
        self.navigationController?.pushViewController(UserDetailsViewController(), animated: true)
    }
    
    @objc func didTapAddUserButton() {
        let vc = StoreUserDetailsViewController()
        vc.signUpViewControllerDelegate = self
        self.present(vc, animated: true)
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
            let dateOfBirth = try inputValidationService.validateIsAgeAllowed(signUpView.datePicker.date)
            let addressLine1 = try inputValidationService.validateAddress1(signUpView.addressLine1TextField.text)
            let addressLine2 = try inputValidationService.validateAddress2(signUpView.addressLine2TextField.text)
            let city = try inputValidationService.validateCity(signUpView.cityTextField.text)
            let state = try inputValidationService.validateState(signUpView.stateTextField.text)
            let country = try inputValidationService.validateCountry(signUpView.countryTextField.text)
            let zipCode = try inputValidationService.validateZipCode(signUpView.zipCodeTextField.text)

            self.presentAlert(with: "Welcome \(firstName) \(lastName)")
            
        } catch let err {
            switch err {
            case ValidationError.firstNameTooLong,
                 ValidationError.firstNameTooShort,
                 ValidationError.firstNameMustBeEnter:
                print("First name error.")
                
            case ValidationError.lastNameTooLong,
                 ValidationError.lastNameTooShort,
                 ValidationError.lastNameMustBeEnter:
                print("Last name error.")
            
            case ValidationError.middleNameTooLong,
                 ValidationError.middleNameTooShort,
                 ValidationError.middleNameMustBeEnter:
                 print("Middle name error.")
                
            case ValidationError.genderMustBeSelected:
                print("Gender error.")
                
            case ValidationError.emailNotValid,
                ValidationError.emailMustBeEnter:
                print("Email error.")
                
            case ValidationError.weakPassword,
                ValidationError.passwordTooLong,
                ValidationError.passwordTooShort,
                ValidationError.passwordMustBeEnter:
                print("Password error.")
                
            case ValidationError.passwordNotSame,
                ValidationError.confirmPasswordMustBeEnter:
                print("Confirm password error.")
                
            case ValidationError.ageNotAllowed:
                print("Age error.")
                
            case ValidationError.address1TooShort,
                 ValidationError.address1MustBeEnter:
                print("Address 1 error.")
                
            case ValidationError.address2TooShort,
                ValidationError.address2MustBeEnter:
                print("Address 2 error.")
                
            case ValidationError.cityTooShort,
                ValidationError.cityMustBeEnter:
                print("City error.")
                
            case ValidationError.stateTooShort,
                ValidationError.stateMustBeEnter:
                print("State error.")
                
            case ValidationError.countryTooShort,
                ValidationError.countryMustBeEnter:
                print("Country error.")
                
            case ValidationError.zipCodeMustBeEnter,
                ValidationError.zipCodeMustBeNumeric:
                print("Zip code error.")
            default:
                print("Some thing went wrong.")
            }
            self.present(err)
        }
    }
    deinit {
        print("\(SignUpViewController.self) Deinitialized.")
    }
    
}

extension UIViewController {
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
