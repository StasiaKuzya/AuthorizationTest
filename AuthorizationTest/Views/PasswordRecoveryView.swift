//
//  PasswordRecoveryView.swift
//  AuthorizationTest
//
//  Created by Анастасия on 13.05.2024.
//

import SwiftUI
import Firebase

struct PasswordRecoveryView: View {
    @Binding var showModal: Bool
    @StateObject private var viewModel = PasswordRecoveryViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.tomato, Color.sandy]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                VStack(alignment: .leading,spacing: 20) {
                    Text("Password Recovery")
                        .bold()
                        .font(.title)
                        .foregroundColor(.onyx)
                    
                    EmailTextField(email: $viewModel.email)
                }
                
                VStack(spacing: 10) {
                    ButtonView(
                        buttonText: "Send Recovery Email",
                        buttonAction: { viewModel.sendPasswordReset() },
                        backgroundColor: .haki,
                        foregroundColor: .white)
                    
                    ButtonView(
                        buttonText: "Cancel",
                        buttonAction: { showModal = false },
                        backgroundColor: .onyx,
                        foregroundColor: .white)
                }
                .padding(.bottom, 16)
            }
            .padding([.leading, .trailing], 16)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text(viewModel.alertText),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text("OK"),
                                            action: {
                                                if viewModel.alertText == "Successful Password Reset" {
                                                    showModal = false
                                                }
                                            })
                )
            }
        }
    }
}

#Preview {
    PasswordRecoveryView(showModal: .constant(true))
}
