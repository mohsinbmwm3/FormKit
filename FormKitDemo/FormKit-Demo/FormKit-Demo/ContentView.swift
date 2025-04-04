//
//  ContentView.swift
//  FormKit-Demo
//
//  Created by Mohsin Khan on 03/04/25.
//

import SwiftUI
import FormKit

struct ContentView: View {
    @StateObject var form = FormModel {
        ("email", FormField(value: "", validators: [
            .required(message: "Email is required")
        ]))
        ("password", FormField(value: "", validators: [
            .required(),
            .custom { $0.count < 6 ? "Too short" : nil }
        ]))
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Login Form")) {
                    TextField("Email", text: form.binding(for: "email"))
                        .autocapitalization(.none)
                    if let error = form.error(for: "email") {
                        Text(error).foregroundColor(.red)
                    }

                    SecureField("Password", text: form.binding(for: "password"))
                    if let error = form.error(for: "password") {
                        Text(error).foregroundColor(.red)
                    }
                    
                    Text("Is form valid: \(form.isValid ? "✅" : "❌")")
                        .foregroundColor(form.isValid ? .green : .red)
                }

                Section {
                    Button("Submit") {
                        print("Form Submitted")
                    }
                    .disabled(!form.isValid)
                }
            }
            .navigationTitle("FormKit Demo")
        }
    }
}

#Preview {
    ContentView()
}
