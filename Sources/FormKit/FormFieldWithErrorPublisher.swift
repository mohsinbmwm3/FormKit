//
//  File.swift
//  FormKit
//
//  Created by Mohsin Khan on 04/04/25.
//

import Combine

@MainActor
public protocol FormFieldWithErrorPublisher {
    var errorPublisher: AnyPublisher<String?, Never> { get }
}

extension FormField: FormFieldWithErrorPublisher {
    public var errorPublisher: AnyPublisher<String?, Never> {
        $error.eraseToAnyPublisher()
    }
}
