//
//  DataSourceTests.swift
//  EmptyState_Tests
//
//  Created by Jorge Ovalle on 2/13/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import UIKit
@testable import EmptyStateKit

class DataSourceTests: XCTestCase {
    // MARK: - Default protocol implementation
    
    func testDefaultTableDataSetProperties() {
        let defaultTableViewController = DefaultTableViewController()
        
        let titleDataSource = defaultTableViewController.tableView.emptyStateDataSource?.titleForEmptyDataSet()
        XCTAssertEqual(EmptyStateView.Defaults.title, titleDataSource)
        
        let descriptionDataSource = defaultTableViewController.tableView.emptyStateDataSource?.descriptionForEmptyDataSet()
        XCTAssertEqual(EmptyStateView.Defaults.description, descriptionDataSource)
        
        let imageDataSource = defaultTableViewController.tableView.emptyStateDataSource?.imageForEmptyDataSet()
        XCTAssertEqual(EmptyStateView.Defaults.image, imageDataSource)
        XCTAssertNotNil(imageDataSource)
    }
    
    func testDefaultCollectionDataSetProperties() {
        let defaultCollectionViewController = DefaultCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let titleDataSource = defaultCollectionViewController.collectionView.emptyStateDataSource?.titleForEmptyDataSet()
        XCTAssertEqual(EmptyStateView.Defaults.title, titleDataSource)
        
        let descriptionDataSource = defaultCollectionViewController.collectionView.emptyStateDataSource?.descriptionForEmptyDataSet()
        XCTAssertEqual(EmptyStateView.Defaults.description, descriptionDataSource)
        
        let imageDataSource = defaultCollectionViewController.collectionView.emptyStateDataSource?.imageForEmptyDataSet()
        
        XCTAssertEqual(EmptyStateView.Defaults.image, imageDataSource)
        XCTAssertNotNil(imageDataSource)
    }
    
    // MARK: - Custom protocol implementation for default component
    
    func testTableCustomDataSetProperties() {
        let customTableViewController = CustomTableViewController()
        
        let title = NSAttributedString(string: "Test title")
        let titleDataSource = customTableViewController.tableView.emptyStateDataSource?.titleForEmptyDataSet()
        XCTAssertEqual(title, titleDataSource)
        
        let description = NSAttributedString(string: "Test description")
        let descriptionDataSource = customTableViewController.tableView.emptyStateDataSource?.descriptionForEmptyDataSet()
        XCTAssertEqual(description, descriptionDataSource)
        
        let imageDataSource = customTableViewController.tableView.emptyStateDataSource?.imageForEmptyDataSet()
        XCTAssertNil(imageDataSource)
    }
    
    func testCollectionCustomDataSetProperties() {
        let customCollectionViewController = CustomCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let title = NSAttributedString(string: "Test title")
        let titleDataSource = customCollectionViewController.collectionView.emptyStateDataSource?.titleForEmptyDataSet()
        XCTAssertEqual(title, titleDataSource)
        
        let description = NSAttributedString(string: "Test description")
        let descriptionDataSource = customCollectionViewController.collectionView.emptyStateDataSource?.descriptionForEmptyDataSet()
        XCTAssertEqual(description, descriptionDataSource)
        
        let imageDataSource = customCollectionViewController.collectionView.emptyStateDataSource?.imageForEmptyDataSet()
        XCTAssertNil(imageDataSource)
    }
    
    // MARK: Custom view on data source
    
    func testTableCustomEmptyStateView() {
        let customTableViewController = CustomEmptyStateTableViewController()
        
        let view = UIView()
        view.backgroundColor = .green
        
        XCTAssertEqual(customTableViewController.tableView.emptyStateDataSource?.customViewForEmptyState()?.backgroundColor, view.backgroundColor)
    }
    
    func testCollectionCustomEmptyStateView() {
        let customCollectionViewController = CustomEmptyStateCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let view = UIView()
        view.backgroundColor = .green
        
        XCTAssertEqual(customCollectionViewController.collectionView.emptyStateDataSource?.customViewForEmptyState()?.backgroundColor, view.backgroundColor)
    }
    
    
}
