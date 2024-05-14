//
//  ContentView.swift
//  AuthorizationTest
//
//  Created by Анастасия on 13.05.2024.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.tomato, Color.sandy]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .trailing) {
                    VStack(alignment: .leading,spacing: 20) {
                        HeadlineView()
                        EmailTextField(email: $viewModel.email)
                        PasswordSecureField(password: $viewModel.password, text: "Password")
                    }
                    
                    Button("Forgot Password?") {
                        self.viewModel.showPasswordRecovery = true
                        
                    }
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.alabaster)
                    
                    
                    VStack(spacing: 10) {
                        NavigationLink(destination: MainView(showModal: $viewModel.showMain), isActive: $viewModel.showMain) {
                            ButtonView(
                            buttonText: "Login",
                            buttonAction: { viewModel.loginUserWithEmail() },
                            backgroundColor: .haki,
                            foregroundColor: .white)
                            .alert(isPresented: $viewModel.showAlert) {
                            Alert(
                                title: Text("Login Error"),
                                message: Text(viewModel.alertMessage),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                        }
                        ButtonView(
                            buttonText: "Sign Up",
                            buttonAction: { self.viewModel.showSignUp = true },
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
                .fullScreenCover(isPresented: $viewModel.showPasswordRecovery) {
                    PasswordRecoveryView(showModal: $viewModel.showPasswordRecovery)
                }
                .fullScreenCover(isPresented: $viewModel.showSignUp) {
                    SignUpView(showModal: $viewModel.showSignUp)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
