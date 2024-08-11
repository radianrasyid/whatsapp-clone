//
//  WhatsappChatsModel.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 05/08/24.
//

import Foundation
import SwiftUI
import SwiftData

struct WhatsappChatsModel: Identifiable {
    let id = UUID()
    var username: String
    var latestActivityTime: String
    let latestChatBubble: String
    var pinned: Bool
    var totalUnreadedChat: Int
}

@Model
class WhatsappChatsModelPersisted{
    @Attribute(.unique) var id: UUID
    var username: String
    var latestActivityTime: String
    var latestChatBubble: String
    var pinned: Bool
    var totalUnreadedChat: Int
    
    init(id: UUID, username: String, latestActivityTime: String, latestChatBubble: String, pinned: Bool, totalUnreadedChat: Int) {
        self.id = id
        self.username = username
        self.latestActivityTime = latestActivityTime
        self.latestChatBubble = latestChatBubble
        self.pinned = pinned
        self.totalUnreadedChat = totalUnreadedChat
    }
}
