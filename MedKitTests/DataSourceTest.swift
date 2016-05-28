//
//  DataSourceTest.swift
//  MedKit
//
//  Created by Ahmed Onawale on 5/28/16.
//  Copyright © 2016 Ahmed Onawale. All rights reserved.
//

import Foundation
import UIKit
import XCTest

@testable import MedKit


class DataSourceA<Element, ListView>: DataSource {
    
    var listView: ListView
    var elements: [[Element]]
    
    required init(_ elements: [[Element]], listView: ListView) {
        self.elements = elements
        self.listView = listView
    }
    
}

class DataSourceTest: MedKitTests {
    
    let dataSource = DataSourceA([["exit", "import", "require", "catch"], ["Javascript", "Go", "Swift"]], listView: UIView())
    func testNumberOfElements() {
        XCTAssertEqual(dataSource.countElementsIn(section: 0), 4)
        XCTAssertEqual(dataSource.countElementsIn(section: 1), 3)
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(dataSource.numberOfSections, 2)
    }
    
    func testElementAtIndexPath() {
        XCTAssertEqual(dataSource[NSIndexPath(forRow: 0, inSection: 0)], "exit")
        XCTAssertEqual(dataSource[NSIndexPath(forRow: 1, inSection: 0)], "import")
        XCTAssertEqual(dataSource[NSIndexPath(forRow: 2, inSection: 0)], "require")
        XCTAssertEqual(dataSource[NSIndexPath(forRow: 3, inSection: 0)], "catch")
        
        XCTAssertEqual(dataSource[NSIndexPath(forRow: 0, inSection: 1)], "Javascript")
        XCTAssertEqual(dataSource[NSIndexPath(forRow: 1, inSection: 1)], "Go")
        XCTAssertEqual(dataSource[NSIndexPath(forRow: 2, inSection: 1)], "Swift")
    }
    
    func testElementsInSection() {
        XCTAssertEqual(dataSource.elementsIn(section: 0), ["exit", "import", "require", "catch"])
        XCTAssertEqual(dataSource.elementsIn(section: 1), ["Javascript", "Go", "Swift"])
    }
    
}