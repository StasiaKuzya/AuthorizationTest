//
//  SignUpViewModel.swift
//  AuthorizationTest
//
//  Created by Анастасия on 14.05.2024.
//

import Foundation
import Firebase

final class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    @Published var errorMessage: String = ""
    @Published var showAlert = false
    @Published var alertText: String = ""
    
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
                self.showAlert = true
            }
        }
    }
}
