//
//  ContentView.swift
//  AuthorizationTest
//
//  Created by Анастасия on 13.05.2024.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showSignUp = false
    @State private var showPasswordRecovery = false
    @State private var showMain = false

    var body: some View {
        VStack(spacing: 15) {
            EmailTextField(email: $email)
            PasswordSecureField(password: $password, text: "Password")

            Button("Forgot Password?") {
                self.showPasswordRecovery = true

             }
            .font(.subheadline)
            
            ButtonView(
                buttonText: "Login",
                buttonAction: { loginUserWithEmail() },
                backgroundColor: .green,
                foregroundColor: .white)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Login Error"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            ButtonView(
                buttonText: "Sign up",
                buttonAction: { self.showSignUp = true },
                backgroundColor: .blue,
                foregroundColor: .white)
        }
        .padding([.leading, .trailing], 16)
        .fullScreenCover(isPresented: $showPasswordRecovery) {
            PasswordRecoveryView(
                email: $email,
                showModal: $showPasswordRecovery
            )
        }
        .fullScreenCover(isPresented: $showSignUp) {
            SignUpView(
                showModal: $showSignUp
            )
        }
        .fullScreenCover(isPresented: $showMain) {
            MainView(
                showModal: $showMain
            )
        }
    }
    
    private func loginUserWithEmail() {
        guard !email.isEmpty, !password.isEmpty else {
            alertMessage = "Please enter both email and password."
            showAlert = true
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                alertMessage = error.localizedDescription
                showAlert = true
            } else {
                // Пользователь успешно вошел в систему.
                print("User successfully signed in the system")
                self.showMain = true
                
            }
        }
    }
}

#Preview {
    LoginView()
}
