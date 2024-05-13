//
//  Button.swift
//  AuthorizationTest
//
//  Created by Анастасия on 13.05.2024.
//

import SwiftUI

struct ButtonView: View {
    var buttonText: String
    var buttonAction: () -> Void
    var backgroundColor: Color
    var foregroundColor: Color

    var body: some View {
        Button(action: buttonAction) {
            Text(buttonText)
                .padding()
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .bold()
                .overlay(
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(.gray, lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
        }
    }
}

#Preview {
    ButtonView(
        buttonText: "String",
        buttonAction: {},
        backgroundColor: .blue,
        foregroundColor: .white)
}
