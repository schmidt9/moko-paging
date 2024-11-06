/*
 * Copyright 2020 IceRock MAG Inc. Use of this source code is governed by the Apache 2.0 license.
 */

import UIKit
import MultiPlatformLibrary
import MultiPlatformLibraryUnits

class TestViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    private var listViewModel: ListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let unitsSource = TableUnitsSourceKt.default(for: tableView)
        listViewModel = ListViewModel(unitsFactory: self)
        
        tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        
        listViewModel.state.data().addObserver { data in
            guard let units = data as? [TableUnitItem] else { return }
            
            unitsSource.unitItems = units
        }
        listViewModel.isRefreshing.addObserver { refreshing in
            if refreshing == false {
                refreshControl.endRefreshing()
            }
        }
    }
    
    @objc func onRefresh() {
        listViewModel.onRefresh()
    }
}

extension TestViewController: ListViewModelUnitsFactory {
    func createLoading() -> TableUnitItem {
        return UITableViewCellUnit<LoadingTableViewCell>(
            data: Void(),
            itemId: -2,
            configurator: nil
        )
    }
    
    func createProductUnit(id: Int64, title: String) -> TableUnitItem {
        return UITableViewCellUnit<ProductTableViewCell>(
            data: title,
            itemId: id,
            configurator: nil
        )
    }
}

extension TestViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
            listViewModel.onLoadNextPage()
        }
    }
}




