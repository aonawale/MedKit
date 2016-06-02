//
//  SegueIdentifiableTest.swift
//  MedKit
//
//  Created by Ahmed Onawale on 6/1/16.
//  Copyright © 2016 Ahmed Onawale. All rights reserved.
//

import UIKit
import XCTest
@testable import MedKit

class ViewController: UIViewController, SegueIdentifiable {
    
    enum SegueIdentifier: String {
        case GoToFront
        case GoToBack
    }
    
}

class SegueIdentifiableTest: MedKitTests {
    
    func testSegueIdentifier() {
        let segue = UIStoryboardSegue(identifier: "GoToFront", source: ViewController(), destination: ViewController())
        let viewController = ViewController()
        XCTAssertNotNil(viewController.segueIdentifierForSegue(segue))
        XCTAssertEqual(viewController.segueIdentifierForSegue(segue)?.rawValue, "GoToFront")
    }
    
}