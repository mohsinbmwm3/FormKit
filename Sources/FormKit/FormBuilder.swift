//
//  FormBuilder.swift
//  FormKit
//
//  Created by Mohsin Khan on 03/04/25.
//

import SwiftUI
import Combine

public typealias AnyFormField = any FormFieldProtocol

@resultBuilder
public struct FormBuilder {
    public static func buildBlock(_ components: (String, AnyFormField)...) -> [String: AnyFormField] {
        Dictionary(uniqueKeysWithValues: components)
    }
}

