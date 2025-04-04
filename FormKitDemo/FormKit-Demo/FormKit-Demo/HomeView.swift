//
//  HomeView.swift
//  FormKit-Demo
//
//  Created by Mohsin Khan on 04/04/25.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: LoginView()) {
                    Text("Login Form")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                NavigationLink(destination: RegistrationView()) {
                    Text("Registration Form")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("FormKit Demo")
        }
    }
}
