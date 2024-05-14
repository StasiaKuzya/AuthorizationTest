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
        VStack() {
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
            NavigationLink(
                destination: MainView(showModal: $authManager.isSignedIn),
                isActive: $authManager.isSignedIn) {
                    EmptyView()
                }.hidden()
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
