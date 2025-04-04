//
//  Commo.swift
//  FormKit-Demo
//
//  Created by Mohsin Khan on 04/04/25.
//

import Foundation
import SwiftUI

@ViewBuilder
func validatedField(
    label: String,
    binding: Binding<String>,
    error: String?,
    touched: Bool,
    isSecure: Bool = false
) -> some View {
    VStack(alignment: .leading, spacing: 4) {
        Text(label)
            .font(.subheadline)

        Group {
            if isSecure {
                SecureField(label, text: binding)
            } else {
                TextField(label, text: binding)
            }
        }
        .padding(8)
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
        )

        if let error = error, touched {
            Text(error)
                .font(.caption)
                .foregroundColor(.red)
        }
    }
}
