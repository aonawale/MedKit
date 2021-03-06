//
//  FetchedCollectionDataSouce.swift
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
import CoreData

public class FetchedCollectionDataSource<Element: NSManagedObject, ListView: UICollectionView>: CollectionDataSource<Element, ListView>, FetchedDataSource, NSFetchedResultsControllerDelegate {
    
    public var operations = [NSBlockOperation]()
    public let fetchedResultsController: NSFetchedResultsController
    
    public required init(listView: ListView, fetchedResultsController: NSFetchedResultsController) {
        self.fetchedResultsController = fetchedResultsController
        super.init([[]], listView: listView)
        self.fetchedResultsController.delegate = self
        performFetch()
    }

    private func addOperationBlock(block: (Void) -> Void) {
        operations.append(NSBlockOperation(block: block))
    }
    
    public override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countElementsIn(section: section)
    }
    
    public override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return numberOfSections
    }

    public func controllerWillChangeContent(controller: NSFetchedResultsController) {
        operations.removeAll()
    }
    
    public func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        let indexSet = NSIndexSet(index: sectionIndex)
        switch type {
        case .Insert:
            addOperationBlock { self.listView.insertSections(indexSet) }
        case .Update:
            addOperationBlock { self.listView.reloadSections(indexSet) }
        case .Delete:
            addOperationBlock { self.listView.deleteSections(indexSet) }
        default:
            break
        }
    }
    
    public func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            addOperationBlock { self.listView.insertItemsAtIndexPaths([newIndexPath!]) }
        case .Update:
            addOperationBlock { self.listView.reloadItemsAtIndexPaths([indexPath!]) }
        case .Move:
            addOperationBlock { self.listView.moveItemAtIndexPath(indexPath!, toIndexPath: newIndexPath!) }
        case .Delete:
            addOperationBlock { self.listView.deleteItemsAtIndexPaths([indexPath!]) }
        }
    }
    
    public func controllerDidChangeContent(controller: NSFetchedResultsController) {
        listView.performBatchUpdates({
            self.operations.forEach { $0.start() }
        }) { _ in
            self.operations.removeAll()
        }
    }
    
    deinit {
        operations.forEach { $0.cancel() }
        operations.removeAll()
    }
    
}