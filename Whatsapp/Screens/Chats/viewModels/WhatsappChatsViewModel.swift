//
//  WhatsappChatsViewModel.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 05/08/24.
//

import Foundation
import SwiftUI
import Photos

@Observable class WhatsappChatsViewModel {
    var searchText: String = ""
    var isMoreSheetShowed: Bool = false
    var sheetData : WhatsappChatsModel? = nil {
        didSet{
            isMoreSheetShowed = true
        }
    }
    var showingCamera: Bool = false
    var image: UIImage?
    var recentMedia: [MediaItem] = []
    var alphabet = "#ABCDEFGHIJKLMNOPQRSTUVWXYZ".map { String($0) }
    var isCreateChatSheetShowed: Bool = false
    var selectedType = "all"
    var contacts: [String: [Contact]] = [
        "Frequently contacted": [
            Contact(name: "زوجة", details: nil),
            Contact(name: "Radian Rasyid", details: "@radianrasyid"),
            // Add more contacts...
        ],
        "A": [
            Contact(name: "Astral Projection", details: nil),
            // Add more contacts...
        ],
        // Add more sections...
    ]
    var chatData: [WhatsappChatsModel] = [
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
    
    var archivedChatData: [WhatsappChatsModel] = []
    
    func togglePinned(for item: WhatsappChatsModel){
        if let index = chatData.firstIndex(where: {$0.id == item.id}){
            chatData[index].pinned.toggle()
        }
    }
    
    func moveToArchived(for item: WhatsappChatsModel){
        if let index = chatData.firstIndex(where: {$0.id == item.id}){
            archivedChatData.append(chatData[index])
            chatData.remove(at: index)
        }
    }
    
    func toggleRead(for item: WhatsappChatsModel){
        if let index = chatData.firstIndex(where: {
            $0.id == item.id
        }){
            if(chatData[index].totalUnreadedChat > 0){
                chatData[index].totalUnreadedChat = 0
            }else{
                chatData[index].totalUnreadedChat = 1
            }
        }
    }
    
    func deleteAChat(for item: WhatsappChatsModel){
        if let index = chatData.firstIndex(where: {$0.id == item.id}){
            chatData.remove(at: index)
            if let archivedDataIndex = archivedChatData.firstIndex(where: {$0.id == item.id}){
                archivedChatData.remove(at: archivedDataIndex)
            }
        }
    }
    
    func fetchRecentMediaItems(limit: Int = 20) -> [MediaItem] {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.fetchLimit = limit

        let fetchResult = PHAsset.fetchAssets(with: fetchOptions)
        
        return (0..<fetchResult.count).compactMap { index in
            guard let asset = fetchResult.object(at: index) as? PHAsset else { return nil }
            return MediaItem(id: asset.localIdentifier, asset: asset)
        }
    }
}
