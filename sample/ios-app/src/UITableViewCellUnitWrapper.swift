//
//  UITableViewCellUnitWrapper.swift
//  TestProj
//
//  Created by Alexander Kormanovsky on 06.11.2024.
//  Copyright © 2024 IceRock Development. All rights reserved.
//

import Foundation
import MultiPlatformLibrary
import MultiPlatformLibraryUnits

@objcMembers
@objc(TPUITableViewCellUnitWrapper)
public class UITableViewCellUnitWrapper: NSObject {
    
    private var unit: UITableViewCellUnit<LoadingTableViewCell>!
    
    override init() {
        super.init()
    }
    
    class func createLoading() -> TableUnitItem {
        return UITableViewCellUnit<LoadingTableViewCell>(
            data: Void(),
            itemId: -2,
            configurator: nil
        )
    }
    
    class func createProductUnit(id: Int64, title: String) -> TableUnitItem {
        return UITableViewCellUnit<ProductTableViewCell>(
            data: title,
            itemId: id,
            configurator: nil
        )
    }
    
}
