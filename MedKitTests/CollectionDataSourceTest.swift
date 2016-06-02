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

class CollectionDataSourceTest: DataSourceTest {
    
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
    
    
    func testCellAtIndexPath() {
        let cell = collectionDataSource.collectionView(collectionView, cellForItemAtIndexPath: NSIndexPath(forRow: 1, inSection: 0))
        XCTAssertNotNil(cell)
    }
    
}