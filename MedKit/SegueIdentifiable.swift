//
//  SegueIdentifiable.swift
//  MedKit
//
//  Created by Ahmed Onawale on 6/1/16.
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

import Foundation

/// This protocol specifies the requirement of a class that can be identifed by a Segue
public protocol SegueIdentifiable: class {
    /// The type of thing that will be used to identify segues.
    /// This type must conform to the RawRepresentable protocol.
    associatedtype SegueIdentifier: RawRepresentable
}

public extension SegueIdentifiable where Self: UIViewController, SegueIdentifier.RawValue == String {
    /// Initiate with the specified SegueIdentifier from the current view controller storyboard file.
    /// - Parameters:
    ///   - segueIdentifier: A SegueIdentifier type provided when you conform to SegueIdentifiable protocol.
    ///   - sender: The object that initializes the segue.
    func performSegueWithIdentifier(segueIdentifier: SegueIdentifier, sender: AnyObject?) {
        performSegueWithIdentifier(segueIdentifier.rawValue, sender: sender)
    }
    
    /// Returns a SegueIdentifier for a given segue.
    /// - Parameters segue: A UIStoryboardSegue object responsible for performing a segue.
    /// - Returns: A SegueIdentifier type or nil if the segue identifier is invalid.
    func segueIdentifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier? {
        guard let identifier = segue.identifier else { return nil }
        return SegueIdentifier(rawValue: identifier)
    }
    
}