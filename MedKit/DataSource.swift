//
//  DataSource.swift
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

import UIKit

/// This protocol can be adopted by any object, struct or enum capable of showing a list of elements.
/// The adopter must specify what type of element they are showing and 
/// what type of view the elements will be shown in.
public protocol DataSource {
    /// The type of thing that will be shown in the listView.
    associatedtype Element
    /// The list view for the list (i.e. `UITableView` or `UICollectionView`).
    associatedtype ListView
    /// An array of elements of any type.
    /// The type is to be specified by the adopter via an associatedtype called `Element`.
    var elements: [[Element]] { get }
    /// A view for showing the elements.
    /// The type is to be specified by the adopter via an associatedtype called `ListView`.
    var listView: ListView { get }
    /// Initializes a new instance of the conforming type.
    /// - Parameters:
    ///   - elements: A multidimentionsl array of elements.
    ///   - listView: A view to show the list of elements.
    init(_ elements: [[Element]], listView: ListView)
}

/// DataSource extension to implement a basic list methods.
public extension DataSource {
    
    /// Returns the number of elements in a given section.
    /// - Parameter section: The section number of elements to count.
    /// - Returns: The number of elements in the given section.
    func countElementsIn(section section: Int) -> Int {
        return elements[section].count
    }
    
    /// Returns the elements in a given section.
    /// - Parameter section: The section number of elements to return.
    /// - Returns: An array of elements.
    func elementsIn(section section: Int) -> [Element] {
        return elements[section]
    }
    
    /// Returns an element at indexPath.
    /// An element at a given NSIndexPath or nil if no element exist at the specified indexPath.
    /// - Parameter indexPath: The indexPath locating the element in the array.
    /// - Returns: An element at the givin indexPath or nil if the indexPath is out of range.
    subscript(indexPath: NSIndexPath) -> Element? {
        return elements[safe: indexPath.section]?[safe: indexPath.row]
    }
    
    /// Returns the number of sections in the elements array.
    /// - Returns: The number of sections.
    var numberOfSections: Int {
        return elements.count
    }
    
    /// Convenience initializer for creating a new instance of the conforming type.
    /// - Parameters:
    ///   - elements: A plain array of elements.
    ///   - listView: A view to show the list of elements.
    init(_ elements: [Element], listView: ListView) {
        self.init([elements], listView: listView)
    }
    
}

public extension DataSource where ListView: UITableView {
    
    /// Returns a UITableViewCell at a given indexPath.
    /// A UITableViewCell at a given NSIndexPath or nil if no UITableViewCell exist at the specified indexPath.
    /// - Parameter indexPath: The indexPath locating the UITableViewCell in the UITableView.
    /// - Returns: A UITableViewCell at the givin indexPath or nil if the indexPath is out of range.
    func cellForPath(indexPath: NSIndexPath) -> UITableViewCell? {
        return listView.cellForRowAtIndexPath(indexPath)
    }
    
    /// Returns an index path for a given UITableViewCell.
    /// A index path representing the row and section of the specified cell or nil if the index path is invalid.
    /// - Parameter cell: A cell object of the UITableView.
    /// - Returns: A NSIndexPath at the givin indexPath or nil if the index path is invalid.
    func pathForCell(cell: UITableViewCell) -> NSIndexPath? {
        return listView.indexPathForCell(cell)
    }
    
}

public extension DataSource where ListView: UICollectionView {
    
    /// Returns a UICollectionViewCell at a given indexPath.
    /// A UICollectionViewCell at a given NSIndexPath or nil if no UICollectionViewCell exist at the specified indexPath.
    /// - Parameter indexPath: The indexPath locating the UICollectionViewCell in the UICollectionView.
    /// - Returns: A UICollectionViewCell at the givin indexPath or nil if the indexPath is out of range.
    func cellForPath(indexPath: NSIndexPath) -> UICollectionViewCell? {
        return listView.cellForItemAtIndexPath(indexPath)
    }
    
    /// Returns an index path for a given UICollectionViewCell.
    /// A index path representing the row and section of the specified cell or nil if the index path is invalid.
    /// - Parameter cell: A cell object of the UITableView.
    /// - Returns: A NSIndexPath at the givin indexPath or nil if the index path is invalid.
    func pathForCell(cell: UICollectionViewCell) -> NSIndexPath? {
        return listView.indexPathForCell(cell)
    }
    
}