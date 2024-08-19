//
//  WhatsappSignUpScreen.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 18/08/24.
//

import SwiftUI

struct WhatsappSignUpScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var viewModel: WhatsappAuthScreenModel
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                WhatsappAuthHeader()
                
                WhatsappEmailTextfield(emailTextValue: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                WhatsappUsernameTextField(usernameTextValue: $viewModel.username)
                    .textInputAutocapitalization(.never)
                WhatsappPasswordTextfield(passwordTextValue: $viewModel.password)
                    .textInputAutocapitalization(.never)
                
                WhatsappAuthButton(buttonPlaceholder: "Sign up", onTap: {
                    Task{
                        await viewModel.handleSignUp()
                    }
                })
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
