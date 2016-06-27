//
//  MedKitTests.swift
//  MedKitTests
//
//  Created by Ahmed Onawale on 5/26/16.
//  Copyright © 2016 Ahmed Onawale. All rights reserved.
//

import CoreData
import XCTest
@testable import MedKit

class Item: NSManagedObject {
    @NSManaged var name: String
    
    class func entityName() -> String {
        return "Item"
    }
}

class MedKitTests: XCTestCase {
    
    var testManagedObjectContext: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func setUpCoreData() {
        let bundles = [NSBundle(forClass: MedKitTests.self)]
        guard let model = NSManagedObjectModel.mergedModelFromBundles(bundles) else {
            fatalError("Model not found")
        }
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        try! persistentStoreCoordinator.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil)
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        testManagedObjectContext = managedObjectContext
    }
    
    func tearDownCoreData() {
        let fetchRequest = NSFetchRequest(entityName: Item.entityName())
        do {
            let fetchedObjects = try testManagedObjectContext.executeFetchRequest(fetchRequest) as! [Item]
            fetchedObjects.forEach { testManagedObjectContext.deleteObject($0) }
        } catch {
            XCTFail("\(error)")
        }
        testManagedObjectContext.reset()
        saveCoreData()
    }
    
    func insertObjects(count: Int) {
        for _ in 0..<count {
            insertObject(name: NSUUID().UUIDString)
        }
        saveCoreData()
    }
    
    func insertObject(name name: String) {
        let object = NSEntityDescription.insertNewObjectForEntityForName(Item.entityName(),
                                                                         inManagedObjectContext: testManagedObjectContext) as! Item
        object.name = name
    }
    
    func saveCoreData() {
        do {
            try testManagedObjectContext.save()
        } catch let error {
            XCTFail("\(error)")
        }
    }
    
}