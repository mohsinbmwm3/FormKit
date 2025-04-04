//
//  FormModel.swift
//  FormKit
//
//  Created by Mohsin Khan on 03/04/25.
//

import Combine
import SwiftUI

@MainActor
public final class FormModel: ObservableObject {
    private var fields: [String: any FormFieldProtocol] = [:]
    private var cancellables = Set<AnyCancellable>()

    public init(@FormBuilder _ builder: () -> [String: any FormFieldProtocol]) {
        self.fields = builder()

        for field in fields.values {
            if let field = field as? FormFieldWithErrorPublisher {
                field.errorPublisher
                    .sink { [weak self] _ in
                        self?.objectWillChange.send()
                    }
                    .store(in: &cancellables)
            }
        }
    }

    public func binding<T>(for key: String) -> Binding<T> {
        guard let field = fields[key] as? FormField<T> else {
            fatalError("Invalid type or missing field for key: \(key)")
        }

        return Binding(
            get: { field.value },
            set: { field.value = $0 }
        )
    }

    public func error(for key: String) -> String? {
        (fields[key] as? any FormFieldProtocol)?.error
    }

    public var isValid: Bool {
        fields.values.allSatisfy { $0.isValid }
    }
}

