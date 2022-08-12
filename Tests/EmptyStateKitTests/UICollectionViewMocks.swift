//
//  UICollectionViewMocks.swift
//  EmptyState_Example
//
//  Created by Jorge Ovalle on 6/27/19.
//

import Foundation
import UIKit
import EmptyStateKit

// MARK: Default Empty State on UICollectionView

final class DefaultCollectionViewController: UICollectionViewController, EmptyStateDataSource, EmptyStateDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.emptyStateDataSource = self
        collectionView.emptyStateDelegate = self
    }
    
}

// MARK: Customized default Empty State on UICollectionView

final class CustomCollectionViewController: UICollectionViewController, EmptyStateDataSource, EmptyStateDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.emptyStateDataSource = self
        collectionView.emptyStateDelegate = self
    }
    
    func titleForEmptyDataSet() -> NSAttributedString? {
        return NSAttributedString(string: "Test title")
    }
    
    func descriptionForEmptyDataSet() -> NSAttributedString? {
        return NSAttributedString(string: "Test description")
    }
    
    func imageForEmptyDataSet() -> UIImage? {
        return nil
    }
    
    func enableScrollForEmptyState() -> Bool {
        return false
    }
}

// MARK: Custom Empty State on UICollectionView

final class CustomEmptyStateCollectionViewController: UICollectionViewController, EmptyStateDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.emptyStateDataSource = self
    }
    
    func customViewForEmptyState() -> UIView? {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }
    
}


