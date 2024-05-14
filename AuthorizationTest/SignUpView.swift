//
//  SignUpView.swift
//  AuthorizationTest
//
//  Created by Анастасия on 13.05.2024.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirmation: String = ""
    @State private var errorMessage: String = ""
    @State private var showAlert = false
    @Binding var showModal: Bool
    @State private var alertText: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.tomato, Color.sandy]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
        
            VStack(spacing: 80) {
            VStack(alignment: .leading, spacing: 20) {
                Text("Sign Up")
                    .bold()
                    .font(.title)
                    .foregroundColor(.onyx)
                
                EmailTextField(email: $email)
                PasswordSecureField(password: $password, text: "Password")
                PasswordSecureField(password: $passwordConfirmation, text: "Repeat password")
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(alertText),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"),
                                            action: {
                                                if alertText == "Check your inbox to verify your email." {
                                                    showModal = false
                                                }
                                            })
                )
            }
            
            VStack(spacing: 10) {
                ButtonView(
                    buttonText: "Create account",
                    buttonAction: { signUp() },
                    backgroundColor: .haki,
                    foregroundColor: .white)
                
                ButtonView(
                    buttonText: "Cancel",
                    buttonAction: { showModal = false },
                    backgroundColor: .onyx,
                    foregroundColor: .white)
            }
        }
            .padding([.leading, .trailing, .bottom], 16)
        }
    }
    
    func signUp() {
        guard password == passwordConfirmation else {
            self.errorMessage = "Passwords do not match"
            showAlert = true
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
                self.showAlert = true
                return
            }
            
            Auth.auth().currentUser?.sendEmailVerification { error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    self.errorMessage = "Check your inbox to verify your email."
                    self.alertText = "Successful registration"
                }
            }
        }
    }
}

#Preview {
    SignUpView(showModal: .constant(true))
}
