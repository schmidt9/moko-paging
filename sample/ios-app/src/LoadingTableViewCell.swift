//
//  LoadingTableViewCell.swift
//  TestProj
//
//  Created by Alexander Kormanovsky on 06.11.2024.
//  Copyright © 2024 IceRock Development. All rights reserved.
//

import MultiPlatformLibraryUnits

class LoadingTableViewCell: UITableViewCell, Fillable, Reusable {
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    typealias DataType = Void
    
    nonisolated static func reusableIdentifier() -> String {
        "loading"
    }
    
    nonisolated static func xibName() -> String {
        "LoadingTableViewCell"
    }
    
    nonisolated func fill(_ data: Void) {}
    
    override func prepareForReuse() {
        activityIndicator.startAnimating()
    }
}
