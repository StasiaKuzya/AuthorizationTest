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
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.tomato, Color.sandy]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .trailing) {
                    VStack(alignment: .leading,spacing: 20) {
                        HeadlineView()
                        EmailTextField(email: $email)
                        PasswordSecureField(password: $password, text: "Password")
                    }
                    
                    Button("Forgot Password?") {
                        self.showPasswordRecovery = true
                        
                    }
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.alabaster)
                    
                    
                    VStack(spacing: 10) {
                        NavigationLink(destination: MainView(showModal: $showMain), isActive: $showMain) {
                            ButtonView(
                            buttonText: "Login",
                            buttonAction: { loginUserWithEmail() },
                            backgroundColor: .haki,
                            foregroundColor: .white)
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Login Error"),
                                message: Text(alertMessage),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                        }
                        ButtonView(
                            buttonText: "Sign Up",
                            buttonAction: { self.showSignUp = true },
                            backgroundColor: .onyx,
                            foregroundColor: .white)
                    }
                    .padding(.top, 30)
                    
                    Divider()
                        .font(.largeTitle)
                        .bold()
                        .background(.onyx)
                    
                    GoogleSignInButton()
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
            }
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
                print("User successfully signed in the system")
                self.showMain = true
                
            }
        }
    }
}

#Preview {
    LoginView()
}
