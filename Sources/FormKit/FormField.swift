//
//  FormField.swift
//  FormKit
//
//  Created by Mohsin Khan on 03/04/25.
//

import SwiftUI
import Combine

@MainActor
public final class FormField<Value>: ObservableObject {
    @Published public var value: Value
    @Published public private(set) var error: String?

    private let validators: [Validator<Value>]
    private var cancellables = Set<AnyCancellable>()

    public init(value: Value, validators: [Validator<Value>] = []) {
        self.value = value
        self.validators = validators

        // ✅ Automatically validate on value change (safely)
        $value
            .removeDuplicates(by: { "\($0)" == "\($1)" })
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.validate()
                }
            }
            .store(in: &cancellables)
    }

    public func validate() {
        print("Validating: \(value)")
        let newError = validators
            .compactMap { $0.validate(value) }
            .first

        if newError != error {
            error = newError
        }
    }

    public var isValid: Bool {
        validate()
        return error == nil
    }
}
