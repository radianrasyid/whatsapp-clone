//
//  WhatsappAppStorage.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 07/08/24.
//

import Foundation
import SwiftData

@Model class WhatsappChatsStorage: Identifiable, Hashable{
    var id: UUID
    var username: String
    var latestActivityTime: String
    var latestChatBubble: String
    var pinned: Bool
    var totalUnreadedChat: Int
    
    init(id: UUID = UUID(), username: String, latestActivityTime: String, latestChatBubble: String, pinned: Bool, totalUnreadedChat: Int) {
        self.id = id
        self.username = username
        self.latestActivityTime = latestActivityTime
        self.latestChatBubble = latestChatBubble
        self.pinned = pinned
        self.totalUnreadedChat = totalUnreadedChat
    }
}

@Model class WhatsappArchivedChatsStorage{
    var id: UUID
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
