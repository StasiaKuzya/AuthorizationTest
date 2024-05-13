//
//  PasswordRecoveryView.swift
//  AuthorizationTest
//
//  Created by Анастасия on 13.05.2024.
//

import SwiftUI
import Firebase

struct PasswordRecoveryView: View {
    @Binding var email: String
    @Binding var showModal: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Password Recovery")
                .bold()
                .font(.title)
            
            EmailTextField(email: $email)
            
            ButtonView(
                buttonText: "Send Recovery Email",
                buttonAction: {
                    Auth.auth().sendPasswordReset(withEmail: email) { error in
                        if let error = error {
                            // Обработка ошибки...
                        } else {
                            // Успешная отправка письма...
                        }
                        showModal = false
                    }
                },
                backgroundColor: .green,
                foregroundColor: .white)
            
            ButtonView(
                buttonText: "Chancel",
                buttonAction: { showModal = false },
                backgroundColor: .red,
                foregroundColor: .white)
            
        }
        .padding([.leading, .trailing], 16)
    }
}

#Preview {
    PasswordRecoveryView(
        email: .constant(""),
        showModal: .constant(true))
}
