//
//  ChatModel.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 13/07/24.
//

import Foundation
import SwiftUI

// Enum to represent message sender type
enum MessageSender {
    case user
    case other
}

// Struct to represent a single message
struct Message: Identifiable {
    let id = UUID()
    let content: String
    let sender: MessageSender
    let timestamp: Date
}

// Struct to represent a chat participant
struct Participant: Identifiable {
    let id = UUID()
    let name: String
    let phoneNumber: String
}

// Protocol for common chat properties
protocol Chat: Identifiable {
    var id: UUID { get }
    var name: String { get }
    var messages: [Message] { get set }
    var lastMessageTimestamp: Date? { get }
}

// Struct to represent a private chat
struct PrivateChat: Chat {
    let id = UUID()
    let name: String
    let participant: Participant
    var messages: [Message]
    
    var lastMessageTimestamp: Date? {
        messages.last?.timestamp
    }
}

// Struct to represent a group chat
struct GroupChat: Chat {
    let id = UUID()
    let name: String
    let participants: [Participant]
    var messages: [Message]
    
    var lastMessageTimestamp: Date? {
        messages.last?.timestamp
    }
}

// Mock data
struct ChatMockData {
    static let user = Participant(name: "Me", phoneNumber: "+1234567890")
    
    static let privateChat = PrivateChat(
        name: "Alice",
        participant: Participant(name: "Alice", phoneNumber: "+9876543210"),
        messages: [
            Message(content: "Hey, how are you?", sender: .other, timestamp: Date().addingTimeInterval(-3600)),
            Message(content: "I'm good, thanks! How about you?", sender: .user, timestamp: Date().addingTimeInterval(-3500)),
            Message(content: "Doing great! Want to grab coffee later?", sender: .other, timestamp: Date().addingTimeInterval(-3400))
        ]
    )
    
    static let groupChat = GroupChat(
        name: "Family Group",
        participants: [
            Participant(name: "Mom", phoneNumber: "+1111111111"),
            Participant(name: "Dad", phoneNumber: "+2222222222"),
            Participant(name: "Sister", phoneNumber: "+3333333333")
        ],
        messages: [
            Message(content: "Hello everyone!", sender: .user, timestamp: Date().addingTimeInterval(-7200)),
            Message(content: "Hi dear, how are you?", sender: .other, timestamp: Date().addingTimeInterval(-7100)),
            Message(content: "Hey bro!", sender: .other, timestamp: Date().addingTimeInterval(-7000))
        ]
    )
    
    static let chats: [any Chat] = [privateChat, groupChat]
}
