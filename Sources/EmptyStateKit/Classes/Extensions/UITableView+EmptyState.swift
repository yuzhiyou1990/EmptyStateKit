//
//  UITableView+EmptyState.swift
//  EmptyState
//
//  Created by Jorge Ovalle on 12/5/18.
//  Copyright © 2018 Wizeline. All rights reserved.
//

import Foundation
import UIKit

extension UITableView: EmptyStateProtocol {
    
    public func es_reloadData() {
        self.reloadData()
        self.emptyStateReload()
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
    
    private func emptyStateReload() {
        guard let emptyStateDataSource = emptyStateDataSource else { return }
        
        if numberOfItems == 0 && self.subviews.count > 1 {
            originalScrollingValue = isScrollEnabled
            isScrollEnabled = emptyStateDelegate?.enableScrollForEmptyState() ?? true
            
            addSubview(emptyStateView)
            if let emptyStateView = emptyStateView as? EmptyStateView {
                emptyStateView.backgroundColor = emptyStateDataSource.backgroudColorForEmptyDataSet()
                emptyStateView.titleLabel.attributedText = emptyStateDataSource.titleForEmptyDataSet()
                emptyStateView.descriptionLabel.attributedText = emptyStateDataSource.descriptionForEmptyDataSet()
                emptyStateView.image = emptyStateDataSource.imageForEmptyDataSet()
                emptyStateView.accessibilityDescription = emptyStateDataSource.accessibilityDescriptionForEmptyDataSet()
            } else {
                emptyStateView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    emptyStateView.heightAnchor.constraint(equalTo: heightAnchor),
                    emptyStateView.widthAnchor.constraint(equalTo: widthAnchor),
                    emptyStateView.centerYAnchor.constraint(equalTo: centerYAnchor),
                    emptyStateView.centerXAnchor.constraint(equalTo: centerXAnchor)
                ])
            }
        } else {
            removeEmptyView()
            isScrollEnabled = originalScrollingValue
        }
    }
}
