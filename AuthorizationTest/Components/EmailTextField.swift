//
//  EmailTextField.swift
//  AuthorizationTest
//
//  Created by Анастасия on 13.05.2024.
//

import SwiftUI

struct EmailTextField: View {
    @Binding var email: String

    var body: some View {
        TextField("Email", text: $email)
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
            .disableAutocorrection(true)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10.0)
                .stroke(.gray, lineWidth: 1)
            )
    }
}

#Preview {
    EmailTextField(email: .constant(""))
}
