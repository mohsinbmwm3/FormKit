//
//  RegistrationView.swift
//  FormKit-Demo
//
//  Created by Mohsin Khan on 04/04/25.
//

import SwiftUI
import FormKit

struct RegistrationView: View {
    @StateObject private var form = FormModel {
        ("name", FormField(value: "", validators: [
            .required(message: "Name is required")
        ]))
        ("age", FormField(value: "", validators: [
            .required(),
            .custom {
                guard let age = Int($0) else { return "Must be a number" }
                return age < 18 ? "You must be 18+" : nil
            }
        ]))
        ("bio", FormField(value: "", validators: [
            .custom { $0.count > 0 && $0.count < 10 ? "Too short" : nil }
        ]))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Registration")
                    .font(.largeTitle)

                validatedField(
                    label: "Name",
                    binding: form.binding(for: "name"),
                    error: form.error(for: "name"),
                    touched: form.touched(for: "name")
                )

                validatedField(
                    label: "Age",
                    binding: form.binding(for: "age"),
                    error: form.error(for: "age"),
                    touched: form.touched(for: "age")
                )

                validatedField(
                    label: "Bio (optional)",
                    binding: form.binding(for: "bio"),
                    error: form.error(for: "bio"),
                    touched: form.touched(for: "bio")
                )

                Button("Submit") {
                    form.markAllTouched()
                    print("Registration form submitted, valid: \(form.isValid)")
                }
                .disabled(!form.isValid)

                Text("Form is valid: \(form.isValid ? "✅" : "❌")")
                    .foregroundColor(form.isValid ? .green : .red)
            }
            .padding()
        }
        .navigationTitle("Register")
    }
}
