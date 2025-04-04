//
//  Validator.swift
//  FormKit
//
//  Created by Mohsin Khan on 03/04/25.
//

import SwiftUI
import Combine
import Foundation

public enum Validator<Value> {
    case required(message: String = "This field is required")
    case custom((Value) -> String?)

    func validate(_ value: Value) -> String? {
        switch self {
        case .required(let message):
            if let str = value as? String, str.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return message
            }
            return nil
        case .custom(let closure):
            return closure(value)
        }
    }
}
