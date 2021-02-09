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

    override init(frame: CGRect) {
        userDetailsCollectionViewCell = UserDetailsCollectionViewCell()
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func registerCollectionView(collectionView: UICollectionView) {
        collectionView.backgroundColor = .white
        
        let detailsNib = UINib(nibName: userDetailsCollectionViewCell.identifier, bundle: nil)
        collectionView.register(detailsNib, forCellWithReuseIdentifier: userDetailsCollectionViewCell.identifier)
        
        let detailsNib = UINib(nibName: userDetailsCollectionViewCell.identifier, bundle: nil)
        collectionView.register(detailsNib, forCellWithReuseIdentifier: userDetailsCollectionViewCell.identifier)
    }
    
    func footerSpinner() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        return footerView
    }
}
