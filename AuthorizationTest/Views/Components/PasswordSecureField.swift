//
//  PasswordSecureField.swift
//  AuthorizationTest
//
//  Created by Анастасия on 13.05.2024.
//

import SwiftUI

struct PasswordSecureField: View {
    @Binding var password: String
    var text: String

    var body: some View {
        SecureField(text, text: $password)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10.0)
                .stroke(.darkGrayAsh, lineWidth: 1)
            )
            .background(.picker)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
}

#Preview {
    PasswordSecureField(password: .constant(""), text: "Password")
}
