//
//  WhatsappRootScreen.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 19/08/24.
//

import Foundation
import SwiftUI

struct WhatsappRootScreen: View {
    @State private var viewModel = WhatsappRootScreenViewModel()
    var body: some View {
        switch viewModel.authState {
        case .pending:
            Button(action: {
                print("this is authState: \(viewModel.authState)")
            }, label: {
                Text("Loading..")
            })
            
        case .loggedIn(_):
            WhatsappMainView()
            
        case .loggedOut:
            WhatsappLoginScreen()
        }
    }
}
