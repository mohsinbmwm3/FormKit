//
//  FormField.swift
//  FormKit
//
//  Created by Mohsin Khan on 03/04/25.
//

import Foundation
import Combine

import Foundation
import Combine

@MainActor
public final class FormField<Value>: ObservableObject {
    @Published public var value: Value
    @Published public private(set) var error: String?
    @Published public private(set) var touched: Bool = false

    private let validators: [Validator<Value>]
    private var cancellables = Set<AnyCancellable>()

    public init(value: Value, validators: [Validator<Value>] = []) {
        self.value = value
        self.validators = validators

        // 👇 Validate on every value change
        $value
            .dropFirst() // ⛔ Prevent error on app launch
            .sink { [weak self] _ in
                guard let self else { return }
                if !self.touched {
                    self.touched = true
                }
                self.validate()
            }
            .store(in: &cancellables)
    }

    public func validate() {
        let newError = validators
            .compactMap { $0.validate(value) }
            .first

        error = newError // always assign — trigger reactivity
    }

    public var isValid: Bool {
        error == nil
    }

    public func markTouched() {
        if !touched {
            touched = true
            validate()
        }
    }
}

