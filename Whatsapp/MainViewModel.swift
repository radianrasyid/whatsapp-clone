//
//  MainViewModel.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 04/08/24.
//

import Foundation
import SwiftUI

@Observable class WhatsappMainViewModel {
    var TabItems: [WhatsappMainTabModel<AnyView>] = [
        WhatsappMainTabModel(content: AnyView(WhatsappUpdatesView()), title: "Updates", image: "message.badge.waveform"),
        WhatsappMainTabModel(content: AnyView(WhatsappCallsView()), title: "Calls", image: "phone"),
        WhatsappMainTabModel(content: AnyView(WhatsappCommunitiesView()), title: "Communities", image: "person.3"),
        WhatsappMainTabModel(content: AnyView(WhatsappChatsView()), title: "Chats", image: "message.fill"),
        WhatsappMainTabModel(content: AnyView(WhatsappSettingsView()), title: "Settings", image: "gear")
//        WhatsappChatsView(), WhatsappSettingsView()
    ]
}
