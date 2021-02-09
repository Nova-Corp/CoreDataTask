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
    
    var fetchOffset = 0
    var fetchLimit = 10
    
    func fetchUserListFromDatabase(appDelegate: AppDelegate?) {
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BasicUserDetails")
        fetchRequest.fetchOffset = fetchOffset
        fetchRequest.fetchLimit = fetchLimit
        let sectionSortDescriptor = NSSortDescriptor(key: "age", ascending: true)
        let sortDescriptors = [sectionSortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            let result = try managedContext?.fetch(fetchRequest)
            delegate?.didReceiveUserListData(from: result as? [NSManagedObject])
            
            fetchOffset = fetchOffset + 10
        } catch let err {
            print(err)
            delegate?.didReceiveUserListData(from: nil)
        }
    }
}
