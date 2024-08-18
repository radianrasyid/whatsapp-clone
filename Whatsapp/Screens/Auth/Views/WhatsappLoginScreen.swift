//
//  WhatsappLoginScreen.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 17/08/24.
//

import Foundation
import SwiftUI

struct WhatsappLoginScreen: View {
    @State private var viewModel = WhatsappAuthScreenModel()
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                WhatsappAuthHeader()
                
                WhatsappEmailTextfield(emailTextValue: $viewModel.email)
                    .keyboardType(.emailAddress)
                WhatsappPasswordTextfield(passwordTextValue: $viewModel.password)
                
                HStack{
                    Spacer()
                    Button(action: {}, label: {
                        Text("Forgot password?")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    })
                }
                .padding(.vertical)
                
                WhatsappAuthButton(buttonPlaceholder: "Log in", onTap: {})
                    .disabled(viewModel.disableLoginButton)
                
                Spacer()
                
                signUpButton()
                    .padding(.bottom, 30)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.teal.gradient)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden()
        }
    }
    
    private func signUpButton() -> some View {
        NavigationLink(destination: {
            WhatsappSignUpScreen()
        }, label: {
            HStack{
                Image(systemName: "sparkles")
                (
                    Text("Don't have an account ? ")
                    +
                    Text("Create one")
                        .fontWeight(.bold)
                )
            }
            .foregroundStyle(.white)
        })
        
    }
}

#Preview {
    WhatsappLoginScreen()
}
