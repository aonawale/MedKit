//
//  TableDataSourceTest.swift
//  MedKit
//
//  Created by Ahmed Onawale on 5/26/16.
//  Copyright © 2016 Ahmed Onawale. All rights reserved.
//

import Foundation
import UIKit
import XCTest

@testable import MedKit

class TableDataSourceTest: MedKitTests {
    
    var tableDataSource: TableDataSource<String, UITableView>!
    let tableView = UITableView(frame: CGRectZero, style: .Plain)
    
    override func setUp() {
        super.setUp()
        tableDataSource = TableDataSource([["exit", "import", "require", "catch"], ["Javascript", "Go", "Swift"]], listView: tableView)
    }
    
    override func tearDown() {
        super.tearDown()
        tableDataSource = nil
    }
    
    func testNumberOfElements() {
        XCTAssertEqual(tableDataSource.countElementsIn(section: 0), 4)
        XCTAssertEqual(tableDataSource.countElementsIn(section: 1), 3)
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(tableDataSource.numberOfSections, 2)
    }
    
    func testElementAtIndexPath() {
        XCTAssertEqual(tableDataSource[NSIndexPath(forRow: 0, inSection: 0)], "exit")
        XCTAssertEqual(tableDataSource[NSIndexPath(forRow: 1, inSection: 0)], "import")
        XCTAssertEqual(tableDataSource[NSIndexPath(forRow: 2, inSection: 0)], "require")
        XCTAssertEqual(tableDataSource[NSIndexPath(forRow: 3, inSection: 0)], "catch")
        
        XCTAssertEqual(tableDataSource[NSIndexPath(forRow: 0, inSection: 1)], "Javascript")
        XCTAssertEqual(tableDataSource[NSIndexPath(forRow: 1, inSection: 1)], "Go")
        XCTAssertEqual(tableDataSource[NSIndexPath(forRow: 2, inSection: 1)], "Swift")
    }
    
    func testElementsInSection() {
        XCTAssertEqual(tableDataSource.elementsIn(section: 0), ["exit", "import", "require", "catch"])
        XCTAssertEqual(tableDataSource.elementsIn(section: 1), ["Javascript", "Go", "Swift"])
    }
    
    func testCellAtIndexPath() {
        let cell = tableDataSource.tableView(tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 1, inSection: 0))
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell.textLabel?.text)
        XCTAssertEqual(cell.textLabel!.text!, "Optional(\"import\")")
    }
    
}