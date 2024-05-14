//
//  AlertView.swift
//  AuthorizationTest
//
//  Created by Анастасия on 13.05.2024.
//

import SwiftUI

struct MainView: View {
    @Binding var showModal: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.haki, Color.onyx]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            Text("Hello!")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.picker)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainView(showModal: .constant(true))
}
