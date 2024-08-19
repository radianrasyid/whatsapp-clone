//
//  WhatsappAuthScreenModel.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 19/08/24.
//

import Foundation
import SwiftUI

@Observable
class WhatsappAuthScreenModel {
    var isLoading = false
    var email = ""
    var password = ""
    var username = ""
    var errorState: (showError: Bool, errorMessage: String) = (false, "Uh oh!")
    
    //MARK: Computed properties
    var disableLoginButton: Bool {
        return email.isEmpty || password.isEmpty || isLoading
    }
    
    var disableSignupButton: Bool {
        return email.isEmpty || password.isEmpty || username.isEmpty || isLoading
    }
    
    func handleSignUp() async {
        isLoading = true
        do{
            try await WhatsappAuthManager.shared.createAccount(for: username, with: email, and: password)
            isLoading = false
        }catch{
            errorState.errorMessage = "Failed to create an account: \(error.localizedDescription)"
            errorState.showError = true
            isLoading = false
        }
    }
    
    func handleSignIn() async {
        isLoading = true
        do {
            try await WhatsappAuthManager.shared.login(with: email, password: password)
            isLoading = false
        }catch{
            errorState.errorMessage = "Failed to sign in: \(error.localizedDescription)"
            errorState.showError = true
            isLoading = false
        }
    }
}
