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

class TableDataSourceTest: DataSourceTest {
    
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
    
    func testCellAtIndexPath() {
        let cell = tableDataSource.tableView(tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 1, inSection: 0))
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell.textLabel?.text)
        XCTAssertEqual(cell.textLabel!.text!, "Optional(\"import\")")
    }
    
}