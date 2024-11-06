//
//  ProductTableViewCell.swift
//  TestProj
//
//  Created by Alexander Kormanovsky on 06.11.2024.
//  Copyright © 2024 IceRock Development. All rights reserved.
//

import MultiPlatformLibraryUnits

class ProductTableViewCell: UITableViewCell, @preconcurrency Fillable, Reusable {
    @IBOutlet private var titleLabel: UILabel!
    
    typealias DataType = String
    
    nonisolated static func reusableIdentifier() -> String {
        "product"
    }
    
    nonisolated static func xibName() -> String {
        "ProductTableViewCell"
    }
    
    func fill(_ data: String) {
        titleLabel.text = data
    }
}
