//
//  StoreUserDetailsView.swift
//  CoreDataTask
//
//  Created by ADMIN on 09/02/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import UIKit
import LBTATools

class StoreUserDetailsView: UIView {

    let firstNameTextField = IndentedTextField(placeholder: "First name", padding: 12, cornerRadius: 5, backgroundColor: .white)
    let lastNameTextField = IndentedTextField(placeholder: "Last name", padding: 12, cornerRadius: 5, backgroundColor: .white)
    let emailTextField = IndentedTextField(placeholder: "Email", padding: 12, cornerRadius: 5, keyboardType: .emailAddress, backgroundColor: .white)
    let ageTextField = IndentedTextField(placeholder: "Age", padding: 12, cornerRadius: 5, keyboardType: .numberPad, backgroundColor: .white)
    
    let saveButton = UIButton(title: "Save", titleColor: .white, font: .boldSystemFont(ofSize: 16), backgroundColor: #colorLiteral(red: 0.2883880436, green: 0.5055884719, blue: 0.9490465522, alpha: 1))
    let viewButton = UIButton(title: "View", titleColor: .white, font: .boldSystemFont(ofSize: 16), backgroundColor: #colorLiteral(red: 0.2883880436, green: 0.5055884719, blue: 0.9490465522, alpha: 1))
    
    let addRandomDataButton = UIButton(title: "Add 50 random rata", titleColor: .white, font: .boldSystemFont(ofSize: 16), backgroundColor: #colorLiteral(red: 0.2883880436, green: 0.5055884719, blue: 0.9490465522, alpha: 1))
    
    let deleteAllDataButton = UIButton(title: "Delete all data", titleColor: .white, font: .boldSystemFont(ofSize: 16), backgroundColor: #colorLiteral(red: 0.2883880436, green: 0.5055884719, blue: 0.9490465522, alpha: 1))
    
    func setupDetailsInputFields(vc: LBTAFormController) {
        
        let actionButtonsStack: UIStackView = {
            let btnStack = stack(saveButton, viewButton, spacing: 16, distribution: .fillEqually)
            btnStack.axis = .horizontal
            btnStack.alignment = .center
            return btnStack
        }()
        
        
        [
            firstNameTextField,
            lastNameTextField,
            ageTextField,
            emailTextField
        ].forEach {$0.borderStyle = .roundedRect}
        
        
        
        vc.formContainerStackView.stack(
                    firstNameTextField,
                    lastNameTextField,
                    ageTextField,
                    emailTextField,
                    actionButtonsStack,
                    addRandomDataButton,
                    deleteAllDataButton,
                    spacing: 16
                ).withMargins(.init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    
}
