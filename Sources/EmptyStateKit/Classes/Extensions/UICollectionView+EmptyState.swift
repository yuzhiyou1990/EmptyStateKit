//
//  UICollectionView+EmptyState.swift
//  EmptyState
//
//  Created by Abel Martinez on 4/25/19.
//

import Foundation
import UIKit

extension UICollectionView: EmptyStateProtocol {
    
    public func reloadDataWithEmptyState() {
        self.reloadData()
        self.emptyStateReload(false)
    }
    
    public func reloadDataWithoutEmptyState() {
        self.reloadData()
        self.emptyStateReload(true)
    }
    
    /// The object that acts as the delegate of the empty state view.
    public weak var emptyStateDelegate: EmptyStateDelegate? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.emptyStateDelegate) as? EmptyStateDelegate
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.emptyStateDelegate, newValue, .OBJC_ASSOCIATION_ASSIGN)
            }
        }
    }
    
    /// The object that acts as the data source of the empty state view.
    public weak var emptyStateDataSource: EmptyStateDataSource? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.emptyStateDataSource) as? EmptyStateDataSource
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.emptyStateDataSource, newValue, .OBJC_ASSOCIATION_ASSIGN)
            }
        }
    }
    
    /// The original value before enable/disable scrolling.
    var originalScrollingValue: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.originalScrollingValue) as? Bool) ?? isScrollEnabled
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.originalScrollingValue, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    private func emptyStateReload(_ isHidden: Bool = false) {
        guard let emptyStateDataSource = emptyStateDataSource else { return }
        
        if numberOfItems == 0 && self.subviews.count > 1 && !isHidden {
            originalScrollingValue = isScrollEnabled
            isScrollEnabled = emptyStateDelegate?.enableScrollForEmptyState() ?? true
            
            backgroundView = emptyStateView
            if let emptyStateView = emptyStateView as? EmptyStateView {
                emptyStateView.backgroundColor = emptyStateDataSource.backgroudColorForEmptyDataSet()
                emptyStateView.configData(image: emptyStateDataSource.imageForEmptyDataSet(),
                                          title: emptyStateDataSource.titleForEmptyDataSet(),
                                          desc: emptyStateDataSource.descriptionForEmptyDataSet())
                emptyStateView.accessibilityDescription = emptyStateDataSource.accessibilityDescriptionForEmptyDataSet()
            }
            emptyStateView.translatesAutoresizingMaskIntoConstraints = false
            let height = emptyStateDataSource.heightForEmptyDataSet()
            NSLayoutConstraint.activate([
                emptyStateView.heightAnchor.constraint(equalToConstant: height),
                emptyStateView.widthAnchor.constraint(equalTo: widthAnchor),
                emptyStateView.centerYAnchor.constraint(equalTo: centerYAnchor),
                emptyStateView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        } else {
            // NOTE: As `UICollectionView` is using `backgroundView` we're not calling `removeEmptyView`.
            backgroundView = nil
            isScrollEnabled = originalScrollingValue
        }
    }
}
