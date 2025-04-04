//
//  FormFieldProtocol.swift
//  FormKit
//
//  Created by Mohsin Khan on 03/04/25.
//

import Foundation

@MainActor
public protocol FormFieldProtocol: AnyObject {
    var isValid: Bool { get }
    var error: String? { get }
}


extension FormField: FormFieldProtocol {}
