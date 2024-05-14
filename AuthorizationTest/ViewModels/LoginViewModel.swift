//
//  LoginViewModel.swift
//  AuthorizationTest
//
//  Created by Анастасия on 14.05.2024.
//

import Foundation
import Firebase

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var showSignUp = false
    @Published var showPasswordRecovery = false
    @Published var showMain = false

    func loginUserWithEmail() {
        guard !email.isEmpty, !password.isEmpty else {
            alertMessage = "Please enter both email and password."
            showAlert = true
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.alertMessage = error.localizedDescription
                self.showAlert = true
            } else {
                print("User successfully signed in the system")
                self.showMain = true
            }
        }
    }
}
