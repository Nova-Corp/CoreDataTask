//
//  SpinnerCollectionViewCell.swift
//  CoreDataTask
//
//  Created by ADMIN on 09/02/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import UIKit

class SpinnerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var paginationSpinner: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        paginationSpinner.startAnimating()
    }

}
