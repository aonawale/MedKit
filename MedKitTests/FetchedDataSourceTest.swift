//
//  FetchedDataSourceTest.swift
//  MedKit
//
//  Created by Ahmed Onawale on 6/26/16.
//  Copyright © 2016 Ahmed Onawale. All rights reserved.
//

import CoreData
import Foundation
import XCTest
@testable import MedKit

class FetchedGrocery<Element: NSManagedObject, ListView>: Grocery<Element, ListView>, FetchedDataSource {
    
    var fetchedResultsController: NSFetchedResultsController
    
    required init(listView: ListView, fetchedResultsController: NSFetchedResultsController) {
        self.fetchedResultsController = fetchedResultsController
        super.init([[]], listView: listView)
        performFetch()
    }
    
}

class FetchedDataSourceTest: MedKitTests {
    
    var fetchedGrocery: FetchedGrocery<NSManagedObject, UIView>!
    
    override func setUp() {
        super.setUp()
        setUpCoreData()
        
        insertObjects(5)
        
        let fetchRequest = NSFetchRequest(entityName: Item.entityName())
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: testManagedObjectContext,
                                             sectionNameKeyPath: nil, cacheName: nil)
        fetchedGrocery = FetchedGrocery(listView: UIView(), fetchedResultsController: frc)
    }
    
    override func tearDown() {
        super.tearDown()
        tearDownCoreData()
    }
    
    func testElements() {
        XCTAssertEqual(fetchedGrocery.numberOfSections, 1)
        XCTAssertEqual(fetchedGrocery.countElementsIn(section: 0), 5)
        XCTAssertEqual(fetchedGrocery.fetchedObjects.count, fetchedGrocery.countElementsIn(section: 0))
    }
    
    func testObject() {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        XCTAssertEqual(fetchedGrocery[indexPath], fetchedGrocery.fetchedObjects[0])
    }
    
}