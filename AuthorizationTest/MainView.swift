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
        Text("Hello!")
            .font(.title)
    }
}

#Preview {
    MainView(showModal: .constant(true))
}
