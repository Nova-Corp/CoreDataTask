//
//  UserDetailsViewController.swift
//  CoreDataTask
//
//  Created by ADMIN on 09/02/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import UIKit
import CoreData

class UserDetailsViewController: UICollectionViewController {
    
    let userDetailsView = UserDetailsView()
    let userDetailsDataModel = UserDetailsDataModel()
    
    let managedContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        return managedContext!
    }()
    
    var userList: [BasicUserDetails] = [BasicUserDetails]()
    
    var fetchingMore = false
    
    
    init() {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumLineSpacing = 2
        super.init(collectionViewLayout: collectionViewFlowLayout)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.title = "User List"
        userDetailsView.registerCollectionView(collectionView: collectionView)
        userDetailsDataModel.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userDetailsDataModel.fetchUserListFromDatabase(managedContext: managedContext)
    }
    
    deinit {
        print("\(UserDetailsViewController.self) Deinitialized.")
    }
}

extension UserDetailsViewController: UICollectionViewDelegateFlowLayout, UserListDataSource {
    
    func didReceiveUserListData(from dataModel: [BasicUserDetails]?) {
        
        guard let dataModel = dataModel else { return }
        userList.append(contentsOf: dataModel)
        fetchingMore = false
        collectionView.reloadData()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        if fetchingMore {
            return 2
        }else{
            return 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return userList.count
        }else{
            return 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let user = userList[indexPath.item]
            let userName = "\(user.value(forKeyPath: "firstName") ?? "") \(user.value(forKeyPath: "lastName") ?? "")"
            let userAge = user.value(forKeyPath: "age") as? Int
            let userDetailCell = collectionView.dequeueReusableCell(withReuseIdentifier: userDetailsView.userDetailsCollectionViewCell.identifier, for: indexPath) as! UserDetailsCollectionViewCell
            userDetailCell.userName.text = userName
            userDetailCell.userEmail.text = user.value(forKeyPath: "email") as? String
            userDetailCell.userAge.text = "\(userAge ?? 0)"
            return userDetailCell
        }else{
            let spinnerCell = collectionView.dequeueReusableCell(withReuseIdentifier: userDetailsView.spinnerCollectionViewCell.identifier, for: indexPath) as! SpinnerCollectionViewCell
            spinnerCell.paginationSpinner.startAnimating()
            return spinnerCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: UIScreen.main.bounds.width, height: 78)
        }else{
            return CGSize(width: UIScreen.main.bounds.width, height: 22)
        }
    }
    
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = collectionView.contentSize.height
        if contentHeight != 0 {
            if offsetY > (contentHeight - scrollView.frame.height + 65) {
                if !fetchingMore {
                    fetchingMore = true
                    collectionView.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.userDetailsDataModel.fetchUserListFromDatabase(managedContext: self.managedContext)
                    }
                }
            }
        }
    }
}
