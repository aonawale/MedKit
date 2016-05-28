//
//  CollectionDataSource.swift
//  MedKit
//
//  Created by Ahmed Onawale on 5/28/16.
//  Copyright © 2016 Ahmed Onawale. All rights reserved.
//

import Foundation
import UIKit
import XCTest

@testable import MedKit

class CollectionDataSourceTest: MedKitTests {
    
    var collectionDataSource: CollectionDataSource<String, UICollectionView>!
    let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func setUp() {
        super.setUp()
        collectionDataSource = CollectionDataSource([["exit", "import", "require", "catch"], ["Javascript", "Go", "Swift"]], listView: collectionView)
    }
    
    override func tearDown() {
        super.tearDown()
        collectionDataSource = nil
    }
    
    func testNumberOfElements() {
        print(collectionDataSource.countElementsIn(section: 0))
        XCTAssertEqual(collectionDataSource.countElementsIn(section: 0), 4)
        XCTAssertEqual(collectionDataSource.countElementsIn(section: 1), 3)
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(collectionDataSource.numberOfSections, 2)
    }
    
    func testElementAtIndexPath() {
        XCTAssertEqual(collectionDataSource[NSIndexPath(forRow: 0, inSection: 0)], "exit")
        XCTAssertEqual(collectionDataSource[NSIndexPath(forRow: 1, inSection: 0)], "import")
        XCTAssertEqual(collectionDataSource[NSIndexPath(forRow: 2, inSection: 0)], "require")
        XCTAssertEqual(collectionDataSource[NSIndexPath(forRow: 3, inSection: 0)], "catch")
        
        XCTAssertEqual(collectionDataSource[NSIndexPath(forRow: 0, inSection: 1)], "Javascript")
        XCTAssertEqual(collectionDataSource[NSIndexPath(forRow: 1, inSection: 1)], "Go")
        XCTAssertEqual(collectionDataSource[NSIndexPath(forRow: 2, inSection: 1)], "Swift")
    }
    
    func testElementsInSection() {
        XCTAssertEqual(collectionDataSource.elementsIn(section: 0), ["exit", "import", "require", "catch"])
        XCTAssertEqual(collectionDataSource.elementsIn(section: 1), ["Javascript", "Go", "Swift"])
    }
    
    func testCellAtIndexPath() {
        let cell = collectionDataSource.collectionView(collectionView, cellForItemAtIndexPath: NSIndexPath(forRow: 1, inSection: 0))
        XCTAssertNotNil(cell)
    }
    
}