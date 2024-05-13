//
//  PasswordRecoveryView.swift
//  AuthorizationTest
//
//  Created by Анастасия on 13.05.2024.
//

import SwiftUI
import Firebase

struct PasswordRecoveryView: View {
    @State private var showAlert = false
    @State private var errorMessage: String = ""
    @State private var alertText: String = ""
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
                buttonAction: { sendPasswordReset() },
                backgroundColor: .green,
                foregroundColor: .white)
            
            ButtonView(
                buttonText: "Cancel",
                buttonAction: { showModal = false },
                backgroundColor: .red,
                foregroundColor: .white)
            
        }
        .padding([.leading, .trailing], 16)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertText),
                message: Text(errorMessage),
                dismissButton: .default(Text("OK"),
                action: {
                    if alertText == "Successful Password Reset" {
                        showModal = false
                    }
                })
            )
        }
    }
    
    private func sendPasswordReset() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.alertText = "Reset Password Error"
            } else {
                self.errorMessage = "Check your inbox to reset your password"
                self.alertText = "Successful Password Reset"
            }
            showAlert = true
        }
    }
}

#Preview {
    PasswordRecoveryView(
        email: .constant(""),
        showModal: .constant(true))
}
