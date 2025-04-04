//
//  Validator.swift
//  FormKit
//
//  Created by Mohsin Khan on 03/04/25.
//

import Combine
import Foundation

public enum Validator<Value> {
    case required(message: String = "This field is required")
    case minLength(Int, message: String)
    case custom((Value) -> String?)

    func validate(_ value: Value) -> String? {
        switch self {
        case .required(let msg):
            if let str = value as? String,
               str.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return msg
            }
            return nil

        case .minLength(let min, let msg):
            if let str = value as? String, str.count < min {
                return msg
            }
            return nil

        case .custom(let closure):
            return closure(value)
        }
    }
}

