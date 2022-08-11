//
//  EmptyStateDelegate.swift
//  EmptyState
//
//  Created by Jorge Ovalle on 12/6/18.
//  Copyright © 2018 Wizeline. All rights reserved.
//

import Foundation

public protocol EmptyStateDelegate: AnyObject {

    /// Enables/Disables the scroll when the Empty State is showing.
    func enableScrollForEmptyState() -> Bool
}

public extension EmptyStateDelegate {
    
    func enableScrollForEmptyState() -> Bool {
        return true
    }
    
}
