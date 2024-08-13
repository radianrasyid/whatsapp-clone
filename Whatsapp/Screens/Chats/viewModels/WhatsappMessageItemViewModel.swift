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
        WhatsappMessageItemViewModel(text: "Hi There", direction: .sent, type: .text, status: .read),
        WhatsappMessageItemViewModel(text: "Check out this photo", direction: .received, type: .image, status: .sent),
        WhatsappMessageItemViewModel(text: "Play this video", direction: .sent, type: .video, status: .sent)
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
