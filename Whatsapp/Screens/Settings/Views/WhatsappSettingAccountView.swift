//
//  WhatsappSettingAccountView.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 19/08/24.
//

import SwiftUI

struct WhatsappSettingAccountView: View {
    @Binding var viewModel: WhatsappSettingViewModel
    var body: some View {
        Button(action: {
            viewModel.signOut()
        }, label: {
            Text("Logout")
        })
    }
}
