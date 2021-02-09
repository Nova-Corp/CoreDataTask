//
//  UserDetailsView.swift
//  CoreDataTask
//
//  Created by ADMIN on 09/02/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import UIKit

class UserDetailsView: UIView {

    let userDetailsCollectionViewCell: UserDetailsCollectionViewCell
    let spinnerCollectionViewCell: SpinnerCollectionViewCell
    

    override init(frame: CGRect) {
        userDetailsCollectionViewCell = UserDetailsCollectionViewCell()
        spinnerCollectionViewCell = SpinnerCollectionViewCell()
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func registerCollectionView(collectionView: UICollectionView) {
        collectionView.backgroundColor = .white
        
        let detailsNib = UINib(nibName: userDetailsCollectionViewCell.identifier, bundle: nil)
        collectionView.register(detailsNib, forCellWithReuseIdentifier: userDetailsCollectionViewCell.identifier)
        
        let spinnerNib = UINib(nibName: spinnerCollectionViewCell.identifier, bundle: nil)
        collectionView.register(spinnerNib, forCellWithReuseIdentifier: spinnerCollectionViewCell.identifier)
    }
}
