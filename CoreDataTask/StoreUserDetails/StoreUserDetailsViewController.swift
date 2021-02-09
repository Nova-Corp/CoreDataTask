//
//  StoreUserDetailsViewController.swift
//  CoreDataTask
//
//  Created by ADMIN on 09/02/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import LBTATools
import CoreData

class StoreUserDetailsViewController: LBTAFormController {

    let storeUserDetailsView = StoreUserDetailsView()
    let inputValidationService = InputValidationService()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var signUpViewControllerDelegate: SignUpViewController?
    
    override func loadView() {
        super.loadView()
        storeUserDetailsView.setupDetailsInputFields(vc: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        storeUserDetailsView.saveButton.addTarget(self, action: #selector(validateInputFields), for: .touchUpInside)
        storeUserDetailsView.viewButton.addTarget(self, action: #selector(didTapViewButton), for: .touchUpInside)
        storeUserDetailsView.addRandomData.addTarget(self, action: #selector(didTapAddRandomDataButton), for: .touchUpInside)
    }
    
    @objc func didTapAddRandomDataButton() {
        let managedContext = appDelegate?.persistentContainer.viewContext
        for _ in 0...50 {
            storeToCodeData(managedContext: managedContext!, firstName: "Ramu", lastName: "Lk", email: "asdf@gmail.com", age: 24)
        }
        try! managedContext?.save()
        self.view.makeToast("50 Random details stored successfully.")
    }
    
    @objc func didTapViewButton() {
        self.dismiss(animated: true) {
            self.signUpViewControllerDelegate?.didTapViewUserButton()
        }
    }
    
     @objc func validateInputFields() {
        do {
            let firstName = try inputValidationService.validateFirstName(storeUserDetailsView.firstNameTextField.text)
            let lastName = try inputValidationService.validateLastName(storeUserDetailsView.lastNameTextField.text)
            let age = try inputValidationService.validateAge(storeUserDetailsView.ageTextField.text)
            let email = try inputValidationService.validateEmail(storeUserDetailsView.emailTextField.text)
            
            let managedContext = appDelegate?.persistentContainer.viewContext
            
            storeToCodeData(managedContext: managedContext!, firstName: firstName, lastName: lastName, email: email, age: age)
            [
                storeUserDetailsView.ageTextField,
                storeUserDetailsView.emailTextField,
                storeUserDetailsView.lastNameTextField,
                storeUserDetailsView.firstNameTextField
            ].forEach { $0.text = nil }
            
            self.view.makeToast("Details stored successfully.")
            
            try managedContext?.save()
            
        } catch let err {
            self.view.makeToast(err.localizedDescription)
        }
    }
    
    private func storeToCodeData(managedContext: NSManagedObjectContext, firstName: String, lastName: String, email: String, age: Int){
        if let basicUserDetailsEntity = NSEntityDescription.entity(forEntityName: "BasicUserDetails", in: managedContext) {
            
            let basicUserDetails = NSManagedObject(entity: basicUserDetailsEntity, insertInto: managedContext)
            basicUserDetails.setValue(firstName, forKey: "firstName")
            basicUserDetails.setValue(lastName, forKey: "lastName")
            basicUserDetails.setValue(email, forKey: "email")
            basicUserDetails.setValue(age, forKey: "age")
        }else{
            self.view.makeToast("Entity not found.")
        }
    }

}
