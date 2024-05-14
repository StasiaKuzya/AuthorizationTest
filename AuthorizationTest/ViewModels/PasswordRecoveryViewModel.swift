//
//  PasswordRecoveryViewModel.swift
//  AuthorizationTest
//
//  Created by Анастасия on 14.05.2024.
//

import Foundation
import Firebase

final class PasswordRecoveryViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var errorMessage: String = ""
    @Published var alertText: String = ""
    @Published var email: String = ""
    
    func sendPasswordReset() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.alertText = "Reset Password Error"
            } else {
                self.errorMessage = "Check your inbox to reset your password"
                self.alertText = "Successful Password Reset"
            }
            self.showAlert = true
        }
    }
}
