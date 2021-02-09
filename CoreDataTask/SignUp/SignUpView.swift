//
//  SignUpView.swift
//  CoreDataTask
//
//  Created by ADMIN on 08/02/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import UIKit
import LBTATools
import DropDown

class SignUpView: UIView {

    let firstNameTextField = IndentedTextField(placeholder: "First name", padding: 12, cornerRadius: 5, backgroundColor: .white)
    let lastNameTextField = IndentedTextField(placeholder: "Last name", padding: 12, cornerRadius: 5, backgroundColor: .white)
    let middleNameTextField = IndentedTextField(placeholder: "Middle name", padding: 12, cornerRadius: 5, backgroundColor: .white)
    let emailTextField = IndentedTextField(placeholder: "Email", padding: 12, cornerRadius: 5, keyboardType: .emailAddress, backgroundColor: .white)
    let passwordTextField = IndentedTextField(placeholder: "Password", padding: 12, cornerRadius: 5, backgroundColor: .white, isSecureTextEntry: true)
    let confirmPasswordTextField = IndentedTextField(placeholder: "Confirm password", padding: 12, cornerRadius: 5, backgroundColor: .white, isSecureTextEntry: true)
//    let dateOfBirthTextField = IndentedTextField(placeholder: "Date of Birth", padding: 12, cornerRadius: 5, backgroundColor: .white)
    let addressLine1TextField = IndentedTextField(placeholder: "Address line 1", padding: 12, cornerRadius: 5, backgroundColor: .white)
    let addressLine2TextField = IndentedTextField(placeholder: "Address line 2", padding: 12, cornerRadius: 5, backgroundColor: .white)
    let cityTextField = IndentedTextField(placeholder: "City", padding: 12, cornerRadius: 5, backgroundColor: .white)
    let stateTextField = IndentedTextField(placeholder: "State", padding: 12, cornerRadius: 5, backgroundColor: .white)
    let countryTextField = IndentedTextField(placeholder: "Country", padding: 12, cornerRadius: 5, backgroundColor: .white)
    
    let genderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Gender", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets.left = 10
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor.copy(alpha: 0.5)
        
        return button
    }()
    let chooseGenderDropDown = DropDown()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.heightAnchor.constraint(equalToConstant: 42).isActive = true
        datePicker.layer.borderWidth = 1
        datePicker.layer.cornerRadius = 4
        datePicker.layer.borderColor = UIColor.lightGray.cgColor.copy(alpha: 0.5)
        return datePicker
    }()
    
    let zipCodeTextField = IndentedTextField(placeholder: "Zip Code", padding: 12, cornerRadius: 5, keyboardType: .numberPad, backgroundColor: .white)
    
    let signUpButton = UIButton(title: "Sign Up", titleColor: .white, font: .boldSystemFont(ofSize: 16), backgroundColor: #colorLiteral(red: 0.2883880436, green: 0.5055884719, blue: 0.9490465522, alpha: 1))
    
    func setupSignUpFields(vc: LBTAFormController) {
        
        vc.title = "Sign Up"
        
        genderButton.addTarget(self, action: #selector(chooseGender), for: .touchUpInside)
        
        chooseGenderDropDown.anchorView = genderButton
        chooseGenderDropDown.bottomOffset = CGPoint(x: 0, y: genderButton.bounds.height)
        
        chooseGenderDropDown.dataSource = [
            Gender.male.rawValue,
            Gender.female.rawValue,
            Gender.notSpecified.rawValue,
        ]
        
        // Action triggered on selection
        chooseGenderDropDown.selectionAction = { [weak self] (index, item) in
            self?.genderButton.setTitle(item, for: .normal)
            self?.genderButton.setTitleColor(.black, for: .normal)
            
        }
        
        [
            firstNameTextField,
            lastNameTextField,
            middleNameTextField,
            emailTextField,
            passwordTextField,
            confirmPasswordTextField,
//            dateOfBirthTextField,
            addressLine1TextField,
            addressLine2TextField,
            cityTextField,
            stateTextField,
            countryTextField,
            zipCodeTextField
        ].forEach {$0.borderStyle = .roundedRect}
        
        vc.formContainerStackView.stack(
            firstNameTextField,
            lastNameTextField,
            middleNameTextField,
            genderButton,
            emailTextField,
            passwordTextField,
            confirmPasswordTextField,
//            dateOfBirthTextField,
            datePicker,
            addressLine1TextField,
            addressLine2TextField,
            cityTextField,
            stateTextField,
            countryTextField,
            zipCodeTextField,
            signUpButton,
            spacing: 16
        ).withMargins(.init(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    @objc func chooseGender(){
        chooseGenderDropDown.show()
    }

}
