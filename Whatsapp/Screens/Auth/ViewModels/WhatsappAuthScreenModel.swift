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
    
    //MARK: Computed properties
    var disableLoginButton: Bool {
        return email.isEmpty || password.isEmpty || isLoading
    }
    
    var disableSignupButton: Bool {
        return email.isEmpty || password.isEmpty || username.isEmpty || isLoading
    }
}
