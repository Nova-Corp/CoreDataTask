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
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var userList: [NSManagedObject] = [NSManagedObject]()
    
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
        
        userDetailsDataModel.fetchUserListFromDatabase(appDelegate: appDelegate)
    }
}

extension UserDetailsViewController: UICollectionViewDelegateFlowLayout, UserListDataSource {
    
    func didReceiveUserListData(from dataModel: [NSManagedObject]?) {
        
        guard let dataModel = dataModel else { return }
        userList.append(contentsOf: dataModel)
        collectionView.reloadData()
        fetchingMore = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let user = userList[indexPath.item]
        
        let userName = "\(user.value(forKeyPath: "firstName") ?? "") \(user.value(forKeyPath: "lastName") ?? "")"
        let userAge = user.value(forKeyPath: "age") as? Int
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userDetailsView.userDetailsCollectionViewCell.identifier, for: indexPath) as! UserDetailsCollectionViewCell
        cell.userName.text = userName
        cell.userEmail.text = user.value(forKeyPath: "email") as? String
        cell.userAge.text = "\(userAge ?? 0)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 78)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = collectionView.contentSize.height
        if contentHeight != 0 {
            if offsetY > (contentHeight - scrollView.frame.height) {
                
                if !fetchingMore {
                    fetchingMore = true
                    userDetailsDataModel.fetchUserListFromDatabase(appDelegate: appDelegate)
                }
            }
        }
    }
}
