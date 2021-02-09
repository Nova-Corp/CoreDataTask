//
//  UserDetailsModel.swift
//  CoreDataTask
//
//  Created by ADMIN on 09/02/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import Foundation
import CoreData

protocol UserListDataSource {
    func didReceiveUserListData(from dataModel: [NSManagedObject]? )
}

class UserDetailsDataModel {
    var delegate: UserListDataSource?
    
    func fetchUserListFromDatabase(appDelegate: AppDelegate?) {
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BasicUserDetails")
        
        do {
            let result = try managedContext?.fetch(fetchRequest)
            delegate?.didReceiveUserListData(from: result as? [NSManagedObject])
        } catch let err {
            print(err)
            delegate?.didReceiveUserListData(from: nil)
        }
    }
}
