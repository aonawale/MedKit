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
import Foundation

protocol FetchedDataSource: DataSource {
    var fetchedResultsController: NSFetchedResultsController { get }
    func performFetch()
    init(listView: ListView, fetchedResultsController: NSFetchedResultsController)
}

extension FetchedDataSource {
    
    /// number of elements in section
    func countElementsIn(section section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    /// number of sections
    var numberOfSections: Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    /// get element at indexPath
    subscript(indexPath: NSIndexPath) -> Element {
        return fetchedResultsController.objectAtIndexPath(indexPath) as! Element
    }
    
}

extension FetchedDataSource where Element: NSManagedObject {
    
    /// Calls performFetch method on NSFetchedResultsController
    /// Default implementation throws does not handle error
    /// You should provide your own implementation to handle errors and avoid crash
    func performFetch() {
        try! fetchedResultsController.performFetch()
    }
    
    /// Returns all fetched objects
    var elements: [[Element]] {
        return [fetchedResultsController.fetchedObjects as! [Element]]
    }
    
    /// get elements in section
    func elementsIn(section section: Int) -> [Element] {
        return fetchedResultsController.sections?[section].objects as? [Element] ?? []
    }
    
}