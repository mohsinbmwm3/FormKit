//
//  FormModel.swift
//  FormKit
//
//  Created by Mohsin Khan on 03/04/25.
//

import Combine
import Foundation
import SwiftUI

@MainActor
public final class FormModel: ObservableObject {
    private var fields: [String: any FormFieldProtocol] = [:]
    private var cancellables = Set<AnyCancellable>()

    @Published public private(set) var isValid: Bool = false

    public init(@FormBuilder _ builder: () -> [String: any FormFieldProtocol]) {
        self.fields = builder()

        for field in fields.values {
            if let field = field as? (FormFieldWithPublisher & FormFieldWithValuePublisher) {
                field.errorPublisher
                    .sink { [weak self] _ in
                        self?.updateValidity()
                    }
                    .store(in: &cancellables)
                
                // 👇 listen to .value changes to update validity
                field.valuePublisher
                    .receive(on: RunLoop.main)
                    .sink { [weak self] _ in
                        self?.updateValidity()
                    }
                    .store(in: &cancellables)
            }

            if let field = field as? FormFieldValidatable {
                field.validate()
            }
        }

        updateValidity()
    }

    private func updateValidity() {
        let newIsValid = fields.values.allSatisfy { $0.isValid }
        if isValid != newIsValid {
            isValid = newIsValid
        }
    }

    public func binding<T>(for key: String) -> Binding<T> {
        guard let field = fields[key] as? FormField<T> else {
            fatalError("Invalid field for key: \(key)")
        }

        return Binding(
            get: { field.value },
            set: { field.value = $0 }
        )
    }

    public func error(for key: String) -> String? {
        (fields[key])?.error
    }

    public func touched(for key: String) -> Bool {
        (fields[key] as? FormFieldTouchState)?.touched ?? false
    }

    public func markAllTouched() {
        for value in fields.values {
            (value as? FormFieldTouchable)?.markTouched()
        }

        updateValidity()
    }
    public func validate(field key: String) {
        (fields[key] as? FormFieldValidatable)?.validate()
    }
}

@MainActor
public protocol FormFieldProtocol: AnyObject {
    var isValid: Bool { get }
    var error: String? { get }
}

@MainActor
public protocol FormFieldTouchable {
    func markTouched()
}

@MainActor
public protocol FormFieldTouchState {
    var touched: Bool { get }
}

@MainActor
public protocol FormFieldWithPublisher {
    var errorPublisher: AnyPublisher<String?, Never> { get }
}

@MainActor
public protocol FormFieldWithErrorPublisher {
    var errorPublisher: AnyPublisher<String?, Never> { get }
}

@MainActor
public protocol FormFieldValidatable {
    func validate()
}

@MainActor
public protocol FormFieldWithValuePublisher {
    var valuePublisher: AnyPublisher<Any, Never> { get }
}

extension FormField: FormFieldWithValuePublisher {
    public var valuePublisher: AnyPublisher<Any, Never> {
        $value
            .map { $0 as Any }
            .eraseToAnyPublisher()
    }
}

extension FormField: FormFieldProtocol, FormFieldTouchable, FormFieldTouchState, FormFieldWithPublisher, FormFieldValidatable {
    public var errorPublisher: AnyPublisher<String?, Never> {
        $error.eraseToAnyPublisher()
    }
}
