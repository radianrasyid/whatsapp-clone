//
//  WhatsappSettingViewModel.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 19/08/24.
//

import Foundation
import SwiftUI

@Observable
class WhatsappSettingViewModel {
    var searchableString = ""
    func signOut(){
        Task{
            try await WhatsappAuthManager.shared.logout()
        }
    }
}
