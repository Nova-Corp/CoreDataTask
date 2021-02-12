//
//  StoreUserDetailsViewController.swift
//  CoreDataTask
//
//  Created by ADMIN on 09/02/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import CoreData
import LBTATools

class StoreUserDetailsViewController: LBTAFormController {
    let storeUserDetailsView = StoreUserDetailsView()
    let inputValidationService = InputValidationService()

    let managedContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        return managedContext!
    }()

    weak var signUpViewControllerDelegate: SignUpViewController?

    override func loadView() {
        super.loadView()
        storeUserDetailsView.setupDetailsInputFields(vc: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        storeUserDetailsView.saveButton.addTarget(self, action: #selector(validateInputFields), for: .touchUpInside)
        storeUserDetailsView.viewButton.addTarget(self, action: #selector(didTapViewButton), for: .touchUpInside)
        storeUserDetailsView.addRandomDataButton.addTarget(self, action: #selector(didTapAddRandomDataButton), for: .touchUpInside)
        storeUserDetailsView.deleteAllDataButton.addTarget(self, action: #selector(didTapDeleteAllDataButton), for: .touchUpInside)
    }

    @objc func didTapDeleteAllDataButton() {
        let fetchRequest: NSFetchRequest<BasicUserDetails> = BasicUserDetails.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(fetchRequest)
            for object in results {
                managedContext.delete(object)
            }
            try managedContext.save()
            view.makeToast("All data deleted successfully.")
        } catch let err {
            self.view.makeToast(err.localizedDescription)
        }
    }

    @objc func didTapAddRandomDataButton() {
        for i in 0 ... 49 {
            storeToCoreData(firstName: "Ramu", lastName: "Lk", email: "asdf@gmail.com", age: i + 1)
        }
        view.makeToast("50 Random details stored successfully.")
    }

    @objc func didTapViewButton() {
        dismiss(animated: true) {
            self.signUpViewControllerDelegate?.didTapViewUserButton()
        }
    }

    @objc func validateInputFields() {
        do {
            let firstName = try inputValidationService.validateFirstName(storeUserDetailsView.firstNameTextField.text)
            let lastName = try inputValidationService.validateLastName(storeUserDetailsView.lastNameTextField.text)
            let age = try inputValidationService.validateAge(storeUserDetailsView.ageTextField.text)
            let email = try inputValidationService.validateEmail(storeUserDetailsView.emailTextField.text)

            storeToCoreData(firstName: firstName, lastName: lastName, email: email, age: age)
            [
                storeUserDetailsView.ageTextField,
                storeUserDetailsView.emailTextField,
                storeUserDetailsView.lastNameTextField,
                storeUserDetailsView.firstNameTextField,
            ].forEach { $0.text = nil }

            
            view.makeToast("Details stored successfully.")

        } catch let err {
            self.view.makeToast(err.localizedDescription)
        }
    }

    private func storeToCoreData(firstName: String, lastName: String, email: String, age: Int) {
        let basicUserDetails = BasicUserDetails(context: managedContext)
        
        basicUserDetails.firstName = firstName
        basicUserDetails.lastName = lastName
        basicUserDetails.email = email
        basicUserDetails.age = Int64(age)
        
        try! managedContext.save()
    }

    deinit {
        print("\(StoreUserDetailsViewController.self) Deinitialized.")
    }
}
