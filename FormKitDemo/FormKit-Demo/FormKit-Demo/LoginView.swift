//
//  LoginView.swift
//  FormKit-Demo
//
//  Created by Mohsin Khan on 04/04/25.
//

import SwiftUI
import FormKit

struct LoginView: View {
    @StateObject private var form = FormModel {
        ("email", FormField(value: "", validators: [
            .required(message: "Email is required"),
            .custom { $0.contains("@") ? nil : "Invalid email format" }
        ]))
        ("password", FormField(value: "", validators: [
            .required(),
            .custom { $0.count < 3 ? "Password too short" : nil }
        ]))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Login")
                    .font(.largeTitle)

                validatedField(
                    label: "Email",
                    binding: form.binding(for: "email"),
                    error: form.error(for: "email"),
                    touched: form.touched(for: "email")
                )

                validatedField(
                    label: "Password",
                    binding: form.binding(for: "password"),
                    error: form.error(for: "password"),
                    touched: form.touched(for: "password"),
                    isSecure: true
                )

                Button("Submit") {
                    form.markAllTouched()
                    print("Login form submitted, valid: \(form.isValid)")
                }
                .disabled(!form.isValid)

                Text("Form is valid: \(form.isValid ? "✅" : "❌")")
                    .foregroundColor(form.isValid ? .green : .red)
            }
            .padding()
        }
        .navigationTitle("Login")
    }
}
