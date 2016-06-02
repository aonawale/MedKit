//
//  FetchedDataSource.swift
//  MedKit
//
//  Created by Ahmed Onawale on 5/26/16.
//  Copyright © 2016 Ahmed Onawale. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  * Redistributions of source code must retain the above copyright notice,
//  this list of conditions and the following disclaimer.
//
//  * Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
//  THE POSSIBILITY OF SUCH DAMAGE.
//

import CoreData

/// This protocol can be adopted by any object capable of showing a list of elements of type NSManagedObject.
/// The adopter must specify what type of element they are showing and
/// what type of view the elements will be shown in.
public protocol FetchedDataSource: DataSource {
    /// A NSFetchedResultsController for managing the listView when there are changes in managed objects.
    var fetchedResultsController: NSFetchedResultsController { get }
    /// Calls performFetch method on NSFetchedResultsController.
    /// Default implementation does not handle error.
    /// You should provide your own implementation to handle errors and avoid crash.
    func performFetch()
    /// Initializes a new instance of the conforming type.
    /// - Parameters:
    ///   - listView: A view to show the list of elements.
    ///   - fetchedResultsController: An instance of NSFetchedResultsController.
    init(listView: ListView, fetchedResultsController: NSFetchedResultsController)
}

public extension FetchedDataSource {
    
    /// Returns the number of elements in a given section.
    /// - Parameter section: The section number of elements to count.
    /// - Returns: The number of elements in the given section.
    func countElementsIn(section section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    /// Returns the number of sections in the fetchedResultsController.
    /// - Returns: The number of sections.
    var numberOfSections: Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    /// Returns an element at indexPath.
    /// An element at a given NSIndexPath or nil if no element exist at the specified indexPath.
    /// - Parameter indexPath: The indexPath locating the element in the fetchedResultsController.
    /// - Returns: An element at the givin indexPath or nil if the indexPath is out of range.
    subscript(indexPath: NSIndexPath) -> Element? {
        return fetchedResultsController.objectAtIndexPath(indexPath) as? Element
    }
    
}

public extension FetchedDataSource where Element: NSManagedObject {
    
    /// Calls performFetch method on NSFetchedResultsController.
    /// Default implementation does not handle error.
    /// You should provide your own implementation to handle errors and avoid crash.
    func performFetch() {
        try! fetchedResultsController.performFetch()
    }
    
    /// Returns all fetched object in the fetchedResultsController.
    var elements: [[Element]] {
        return [fetchedResultsController.fetchedObjects as! [Element]]
    }
    
    /// Returns the elements in a given section.
    /// - Parameter section: The section number of elements to return.
    /// - Returns: An array of elements.
    func elementsIn(section section: Int) -> [Element] {
        return fetchedResultsController.sections?[section].objects as? [Element] ?? []
    }
    
}