//
//  WhatsappSignUpScreen.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 18/08/24.
//

import SwiftUI

struct WhatsappSignUpScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = WhatsappAuthScreenModel()
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                WhatsappAuthHeader()
                
                WhatsappEmailTextfield(emailTextValue: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                WhatsappUsernameTextField(usernameTextValue: $viewModel.username)
                WhatsappPasswordTextfield(passwordTextValue: $viewModel.password)
                
                WhatsappAuthButton(buttonPlaceholder: "Sign up", onTap: {})
                    .disabled(viewModel.disableSignupButton)
                
                Spacer()
                
                signUpButton()
                    .padding(.bottom, 30)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGreen).gradient)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden()
        }
    }
    
    private func signUpButton() -> some View {
        Button(action: {
            dismiss()
        }, label: {
            HStack{
                Image(systemName: "sparkles")
                (
                    Text("Already had an account ? ")
                    +
                    Text("Log in")
                        .fontWeight(.bold)
                )
            }
            .foregroundStyle(.white)
        })
        
    }
}

#Preview {
    WhatsappSignUpScreen()
}
