//
//  TPTestViewController.m
//  TestProjObjC
//
//  Created by Alexander Kormanovsky on 06.11.2024.
//  Copyright © 2024 IceRock Development. All rights reserved.
//

#import "TPTestViewController.h"
#import "TestProjObjC-Swift.h"
@import MultiPlatformLibrary;
@import MultiPlatformLibraryUnits;

@interface TPTestViewController () <UITableViewDelegate, MPLListViewModelUnitsFactory>

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TPTestViewController
{
    MPLListViewModel *_listViewModel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    id<MPLTableUnitsSource> unitsSource = [MPLTableUnitsSourceKt createForTableView:self.tableView withReloadHandler:^(UITableView * _Nonnull tableView, NSArray<id<MPLTableUnitItem>> * _Nullable, NSArray<id<MPLTableUnitItem>> * _Nullable) {
        [tableView reloadData];
    }];
    
    _listViewModel = [[MPLListViewModel alloc] initWithUnitsFactory:self];
    
    self.tableView.delegate = self;
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refreshControl;
    
    [_listViewModel.state addObserverObserver:^(MPLResourceState<NSArray<id<MPLTableUnitItem>> *,NSString *> * _Nullable units) {
        unitsSource.unitItems = units.dataValue;
    }];
    
    [_listViewModel.isRefreshing addObserverObserver:^(MPLBoolean * _Nullable refreshing) {
        if (!refreshing.boolValue) {
            [refreshControl endRefreshing];
        }
    }];
}

- (void)onRefresh:(UIRefreshControl *)sender
{
    [_listViewModel onRefresh];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger lastSectionIndex = tableView.numberOfSections - 1;
    NSUInteger lastRowIndex = [tableView numberOfRowsInSection:lastSectionIndex] - 1;
    
    if (indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex) {
        [_listViewModel onLoadNextPage];
    }
}

#pragma mark - MPLListViewModelUnitsFactory

- (nonnull id<MPLTableUnitItem>)createLoading
{
    return [TPUITableViewCellUnitWrapper createLoading];
}

- (nonnull id<MPLTableUnitItem>)createProductUnitId:(int64_t)id title:(nonnull NSString *)title
{
    return [TPUITableViewCellUnitWrapper createProductUnitWithId:id title:title];
}

@end
