//
//  SignUpView.swift
//  AuthorizationTest
//
//  Created by Анастасия on 13.05.2024.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @Binding var showModal: Bool
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.tomato, Color.sandy]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 80) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Sign Up")
                        .bold()
                        .font(.title)
                        .foregroundColor(.onyx)
                    
                    EmailTextField(email: $viewModel.email)
                    PasswordSecureField(password: $viewModel.password, text: "Password")
                    PasswordSecureField(password: $viewModel.passwordConfirmation, text: "Repeat password")
                }
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text(viewModel.alertText),
                        message: Text(viewModel.errorMessage),
                        dismissButton: .default(Text("OK"),
                                                action: {
                                                    if viewModel.alertText == "Successful registration" {
                                                        showModal = false
                                                    }
                                                })
                    )
                }
                
                VStack(spacing: 10) {
                    ButtonView(
                        buttonText: "Create account",
                        buttonAction: { viewModel.signUp() },
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
}

#Preview {
    SignUpView(showModal: .constant(true))
}
