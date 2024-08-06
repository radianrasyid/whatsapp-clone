//
//  WhatsappChatsModel.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 05/08/24.
//

import Foundation
import SwiftUI

struct WhatsappChatsModel: Identifiable {
    let id = UUID()
    var username: String
    var latestActivityTime: String
    let latestChatBubble: String
    var pinned: Bool
    var totalUnreadedChat: Int
}
