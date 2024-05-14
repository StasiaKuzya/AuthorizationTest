//
//  GoogleSignIn.swift
//  AuthorizationTest
//
//  Created by Анастасия on 13.05.2024.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct GoogleSignInButton: View {
    @StateObject var authManager = FirebaseAuthManager()
    
    var body: some View {
        
        Button(action: {
            DispatchQueue.main.async {
                Task {
                    await authManager.signInWithGoogle()
                }
            }
        }) {
            Text("Sign in with Google")
                .foregroundColor(.onyx)
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .frame(alignment: .leading)
                .background(alignment: .leading, content: {
                    Image("Google").resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                    
                })
                .background(.alabaster)
                .overlay(
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(.alabaster, lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
        }
        .onReceive(authManager.$isSignedIn, perform: { isSignedIn in
            if isSignedIn {
                print("Signed in!")
            }
        })
    }
}

#Preview {
    GoogleSignInButton()
}

class FirebaseAuthManager: ObservableObject {
    @Published var isSignedIn = false

    func signInWithGoogle() async {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No client ID found in Firebase")
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = await windowScene.windows.first,
              let rootVC = await window.rootViewController else {
            print("There is no rootVC")
            return
        }

        do {
            let userAuth = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootVC)
            let user = userAuth.user
            guard let idToken = user.idToken else {
                throw NSError(domain: "idToken not found.", code: 1, userInfo: nil)
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            let result = try await Auth.auth().signIn(with: credential)
            let firebaseUser = result.user
            print("User \(String(describing: firebaseUser.uid)) signed with email \(String(describing: firebaseUser.email)).")
            self.isSignedIn = true
        }
        catch {
            print(error.localizedDescription)
            self.isSignedIn = false
        }
    }
}
