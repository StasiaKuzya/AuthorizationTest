//
//  SignUpView.swift
//  AuthorizationTest
//
//  Created by Анастасия on 13.05.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirmation: String = ""
    @State private var errorMessage: String = ""
    @State private var showingAlert = false
    @Binding var showModal: Bool
    @State private var alertText: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Sign Up")
                .bold()
                .font(.title)
            
            EmailTextField(email: $email)
            PasswordSecureField(password: $password, text: "Password")
            PasswordSecureField(password: $passwordConfirmation, text: "Repeat password")
            
            ButtonView(
                buttonText: "Create account",
                buttonAction: { signUp() },
                backgroundColor: .green,
                foregroundColor: .white)
            
            ButtonView(
                buttonText: "Chancel",
                buttonAction: { showModal = false },
                backgroundColor: .red,
                foregroundColor: .white)
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text(alertText),
                message: Text(errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .padding([.leading, .trailing], 16)
    }
    
    func signUp() {
        guard password == passwordConfirmation else {
            self.errorMessage = "Passwords do not match"
            showingAlert = true
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                if error.code == AuthErrorCode.emailAlreadyInUse.rawValue {
                    self.errorMessage = "This email is already in use. Please use another email."
                } else {
                    self.errorMessage = error.localizedDescription
                }
                self.alertText = "Registration Error"
                self.showingAlert = true
                return
            }
            
            Auth.auth().currentUser?.sendEmailVerification { error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    self.errorMessage = "Check your inbox to verify your email."
                    self.alertText = "Successful registration"
                    self.showModal = false
                }
            }
        }
    }
}

#Preview {
    SignUpView(showModal: .constant(true))
}
