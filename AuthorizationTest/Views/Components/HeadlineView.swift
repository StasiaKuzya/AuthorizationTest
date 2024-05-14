//
//  HeadlineView.swift
//  AuthorizationTest
//
//  Created by Анастасия on 13.05.2024.
//

import SwiftUI

struct HeadlineView: View {
    var body: some View {
        VStack() {
            Text("WELCOME")
                .bold()
                .font(.largeTitle)
                .foregroundColor(.onyx)
            Text("Sign in to your account")
                .bold()
                .font(.subheadline)
                .foregroundColor(.onyx)
        }
    }
}

#Preview {
    HeadlineView()
}
