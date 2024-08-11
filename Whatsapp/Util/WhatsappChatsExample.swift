//
//  WhatsappChatsExample.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 08/08/24.
//

import Foundation

class WhatsappChatsExample {
    static var Chats = [
        WhatsappChatsModel(username: "Alice", latestActivityTime: "09:15", latestChatBubble: "Hey, how are you?", pinned: false, totalUnreadedChat: 3),
        WhatsappChatsModel(username: "Bob", latestActivityTime: "Yesterday", latestChatBubble: "See you tomorrow!", pinned: false, totalUnreadedChat: 0),
        WhatsappChatsModel(username: "Charlie", latestActivityTime: "15/07/24", latestChatBubble: "Meeting rescheduled", pinned: true, totalUnreadedChat: 1),
        WhatsappChatsModel(username: "David", latestActivityTime: "Monday", latestChatBubble: "Can you send the file?", pinned: false, totalUnreadedChat: 5),
        WhatsappChatsModel(username: "Eva", latestActivityTime: "10:45", latestChatBubble: "Had a great time!", pinned: true, totalUnreadedChat: 2),
        WhatsappChatsModel(username: "Frank", latestActivityTime: "12:30", latestChatBubble: "Let's catch up soon", pinned: false, totalUnreadedChat: 0),
        WhatsappChatsModel(username: "Grace", latestActivityTime: "03/06/24", latestChatBubble: "Happy Birthday!", pinned: false, totalUnreadedChat: 4),
        WhatsappChatsModel(username: "Hank", latestActivityTime: "Wednesday", latestChatBubble: "I'll call you back", pinned: false, totalUnreadedChat: 0),
        WhatsappChatsModel(username: "Ivy", latestActivityTime: "14:20", latestChatBubble: "Congrats on the promotion!", pinned: false, totalUnreadedChat: 1),
        WhatsappChatsModel(username: "Jake", latestActivityTime: "Friday", latestChatBubble: "Check this out", pinned: true, totalUnreadedChat: 7),
        WhatsappChatsModel(username: "Karen", latestActivityTime: "02/04/24", latestChatBubble: "Good night!", pinned: false, totalUnreadedChat: 0),
        WhatsappChatsModel(username: "Leo", latestActivityTime: "16:50", latestChatBubble: "Where are you?", pinned: false, totalUnreadedChat: 3),
        WhatsappChatsModel(username: "Mia", latestActivityTime: "Saturday", latestChatBubble: "Thanks a lot!", pinned: false, totalUnreadedChat: 0),
        WhatsappChatsModel(username: "Nina", latestActivityTime: "08:00", latestChatBubble: "Let's meet up", pinned: false, totalUnreadedChat: 6),
        WhatsappChatsModel(username: "Oscar", latestActivityTime: "01/08/24", latestChatBubble: "On my way", pinned: true, totalUnreadedChat: 0),
        WhatsappChatsModel(username: "Paul", latestActivityTime: "19:00", latestChatBubble: "Can we talk?", pinned: false, totalUnreadedChat: 1),
        WhatsappChatsModel(username: "Quinn", latestActivityTime: "22:10", latestChatBubble: "See you soon", pinned: false, totalUnreadedChat: 3),
        WhatsappChatsModel(username: "Rachel", latestActivityTime: "Sunday", latestChatBubble: "Got it, thanks!", pinned: false, totalUnreadedChat: 0),
        WhatsappChatsModel(username: "Steve", latestActivityTime: "11:55", latestChatBubble: "Lunch at 1?", pinned: false, totalUnreadedChat: 0),
        WhatsappChatsModel(username: "Tina", latestActivityTime: "18:30", latestChatBubble: "Let's go!", pinned: true, totalUnreadedChat: 8)
    ]
    
    static var Chat = WhatsappChatsModel(username: "Alice", latestActivityTime: "09:15", latestChatBubble: "Hey, how are you?", pinned: false, totalUnreadedChat: 3)
}
