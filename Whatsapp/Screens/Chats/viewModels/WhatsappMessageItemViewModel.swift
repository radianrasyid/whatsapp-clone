//
//  WhatsappMessageItemViewModel.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 13/08/24.
//

import Foundation
import SwiftUI

struct WhatsappMessageItemViewModel: Identifiable {
    let id = UUID().uuidString
    let text: String
    let direction: WhatsappMessageDirection
    let type: WhatsappMessageType
    let status: WhatsappConnectionStatus
    
    var alignment: Alignment {
        return direction == .received ? .leading : .trailing
    }
    
    var horizontalAlignment: HorizontalAlignment {
        return direction == .received ? .leading : .trailing
    }
    
    static let stubMessages: [WhatsappMessageItemViewModel] = [
        WhatsappMessageItemViewModel(text: "Hey, what’s up?", direction: .sent, type: .text, status: .read),
        WhatsappMessageItemViewModel(text: "Not much, just chilling. How about you?", direction: .received, type: .text, status: .read),
        WhatsappMessageItemViewModel(text: "Same here. Want to grab coffee later?", direction: .sent, type: .text, status: .read),
        WhatsappMessageItemViewModel(text: "Sure, sounds good! ☕", direction: .received, type: .text, status: .read),
        WhatsappMessageItemViewModel(text: "Check out this pic I took yesterday", direction: .sent, type: .image, status: .sent),
        WhatsappMessageItemViewModel(text: "Wow, that looks amazing!", direction: .received, type: .text, status: .read),
        WhatsappMessageItemViewModel(text: "Here’s a video from the concert last night 🎶", direction: .received, type: .video, status: .sent),
        WhatsappMessageItemViewModel(text: "That was such a great time!", direction: .sent, type: .text, status: .read)
    ]
}

enum WhatsappMessageDirection {
    case sent, received
    
    static var random: WhatsappMessageDirection {
        return [WhatsappMessageDirection.sent, .received].randomElement() ?? .sent
    }
}

enum WhatsappConnectionStatus {
    case sent, received, read, failed
    
    static var random: WhatsappConnectionStatus {
        return [WhatsappConnectionStatus.read, .received, .sent, .failed].randomElement() ?? .sent
    }
}

enum WhatsappMessageType {
    case text, image, video
}
