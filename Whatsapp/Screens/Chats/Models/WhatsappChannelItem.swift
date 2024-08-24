//
//  WhatsappChannelItem.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 22/08/24.
//

import Foundation

struct WhatsappChannelItem: Identifiable {
    var id: String
    var name: String?
    var lastMessage: String
    var creationDate: Date
    var lastMessageTimestamp: Date
    var membersCount: UInt
    var adminUuids: [String]
    var membersUuids: [String]
    var members: [WhatsappUserItem]
    var thumbnailUrl: String
    
    var isGroupChat: Bool {
        return membersCount > 2
    }
    
    static let placeholder = WhatsappChannelItem(id: "1", lastMessage: "Hello world!", creationDate: Date(), lastMessageTimestamp: Date(), membersCount: 8, adminUuids: ["1", "2"], membersUuids: ["3", "4"], members: [WhatsappUserItem.placeholder], thumbnailUrl: "")
}
