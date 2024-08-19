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
                    .textInputAutocapitalization(.never)
                WhatsappPasswordTextfield(passwordTextValue: $viewModel.password)
                    .textInputAutocapitalization(.never)
                
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
                
                WhatsappAuthButton(buttonPlaceholder: "Log in", onTap: {
                    Task{
                        await viewModel.handleSignIn()
                    }
                })
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
            .alert(isPresented: $viewModel.errorState.showError){
                Alert(
                    title: Text(viewModel.errorState.errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func signUpButton() -> some View {
        NavigationLink(destination: {
            WhatsappSignUpScreen(viewModel: $viewModel)
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
