//
//  DataSourceTest.swift
//  MedKit
//
//  Created by Ahmed Onawale on 5/28/16.
//  Copyright © 2016 Ahmed Onawale. All rights reserved.
//

import UIKit
import XCTest
@testable import MedKit


class Grocery<Element, ListView>: DataSource {
    
    var listView: ListView
    var elements: [[Element]]
    
    required init(_ elements: [[Element]], listView: ListView) {
        self.elements = elements
        self.listView = listView
    }
    
}

class DataSourceTest: MedKitTests {
    
    let dataSource = Grocery([["Butter", "Milk", "Break", "Bacon"], ["Javascript", "Go", "Swift"]], listView: UIView())
    
    func testNumberOfElements() {
        XCTAssertEqual(dataSource.countElementsIn(section: 0), 4)
        XCTAssertEqual(dataSource.countElementsIn(section: 1), 3)
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(dataSource.numberOfSections, 2)
    }
    
    func testElementAtIndexPath() {
        XCTAssertEqual(dataSource[NSIndexPath(forRow: 0, inSection: 0)], "Butter")
        XCTAssertEqual(dataSource[NSIndexPath(forRow: 1, inSection: 0)], "Milk")
        XCTAssertEqual(dataSource[NSIndexPath(forRow: 2, inSection: 0)], "Break")
        XCTAssertEqual(dataSource[NSIndexPath(forRow: 3, inSection: 0)], "Bacon")
        
        XCTAssertEqual(dataSource[NSIndexPath(forRow: 0, inSection: 1)], "Javascript")
        XCTAssertEqual(dataSource[NSIndexPath(forRow: 1, inSection: 1)], "Go")
        XCTAssertEqual(dataSource[NSIndexPath(forRow: 2, inSection: 1)], "Swift")
    }
    
    func testElementsInSection() {
        XCTAssertEqual(dataSource.elementsIn(section: 0), ["Butter", "Milk", "Break", "Bacon"])
        XCTAssertEqual(dataSource.elementsIn(section: 1), ["Javascript", "Go", "Swift"])
    }
    
}