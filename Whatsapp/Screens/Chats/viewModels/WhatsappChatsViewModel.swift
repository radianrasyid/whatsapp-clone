//
//  WhatsappChatsViewModel.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 05/08/24.
//

import Foundation
import SwiftUI
import Photos
import SwiftData

//@Observable class WhatsappChatsViewModel {
//    var modelContext: ModelContext
//    var searchText: String = ""
//    var isMoreSheetShowed: Bool = false
//    var sheetData : WhatsappChatsModel? = nil {
//        didSet{
//            isMoreSheetShowed = true
//        }
//    }
//    var isShowingArchivedChats: Bool = false
//    var showingCamera: Bool = false
//    var image: UIImage?
//    var recentMedia: [MediaItem] = []
//    var alphabet = "#ABCDEFGHIJKLMNOPQRSTUVWXYZ".map { String($0) }
//    var isCreateChatSheetShowed: Bool = false
//    var selectedType = "all"
//    var contacts: [String: [Contact]] = [
//        "Frequently contacted": [
//            Contact(name: "زوجة", details: nil),
//            Contact(name: "Radian Rasyid", details: "@radianrasyid"),
//            // Add more contacts here...
//        ],
//        "A": [
//            Contact(name: "Astral Projection", details: nil),
//            // Add more contacts here...
//        ],
//        // Add more sections here...
//    ]
//    var chatData = [WhatsappChatsStorage]()
//    var archivedChats = [WhatsappArchivedChatsStorage]()
//    
//    init(modelContext: ModelContext) {
//        self.modelContext = modelContext
//        fetchData()
//    }
//    
//    func togglePinned(for item: WhatsappChatsModel){
//        if let index = chatData.firstIndex(where: {$0.id == item.id}){
//            chatData[index].pinned.toggle()
////            var currentWhatsappAppStorage: WhatsappAppStorage = updateStorage()
////            
////            if let index = currentWhatsappAppStorage.chats.firstIndex(where: {$0.id == item.id}){
////                currentWhatsappAppStorage.chats[index].pinned.toggle()
////                do{
////                    try modelContext.save()
////                }catch{
////                    print("Failed to update WhatsappAppStorage: \(error)")
////                }
////            }
//        }
//    }
//    
//    func moveToArchived(for item: WhatsappChatsModel){
////        var currentWhatsappAppStorage: WhatsappAppStorage = updateStorage()
//        if let index = chatData.firstIndex(where: {$0.id == item.id}){
//            archivedChats.append(WhatsappArchivedChatsStorage(id: chatData[index].id, username: chatData[index].username, latestActivityTime: chatData[index].latestActivityTime, latestChatBubble: chatData[index].latestChatBubble, pinned: chatData[index].pinned, totalUnreadedChat: chatData[index].totalUnreadedChat))
////            currentWhatsappAppStorage.archivedChats.append(WhatsappChatsModelPersisted(id: chatData[index].id, username: chatData[index].username, latestActivityTime: chatData[index].latestActivityTime, latestChatBubble: chatData[index].latestChatBubble, pinned: chatData[index].pinned, totalUnreadedChat: chatData[index].totalUnreadedChat))
//            chatData.remove(at: index)
////            currentWhatsappAppStorage.chats.remove(at: index)
////            do{
////                try modelContext.save()
////            }catch{
////                print("Failed to update WhatsappAppStorage: \(error)")
////            }
//        }
//    }
//    
//    func moveToUnarchived(for item: WhatsappChatsModel){
//        if let index = archivedChatData.firstIndex(where: {$0.id == item.id}){
//            chatData.append(archivedChatData[index])
//            
//            archivedChatData.remove(at: index)
//        }
//    }
//    
////    @MainActor
//    func toggleRead(for item: WhatsappChatsModel){
////        var currentWhatsappAppStorage: WhatsappAppStorage = updateStorage()
//        if let index = chatData.firstIndex(where: {
//            $0.id == item.id
//        }){
//            if(chatData[index].totalUnreadedChat > 0){
//                chatData[index].totalUnreadedChat = 0
//            }else{
//                chatData[index].totalUnreadedChat = 1
//            }
//        }
//        
////        if let index = currentWhatsappAppStorage.chats.firstIndex(where: {$0.id == item.id}){
////            if(currentWhatsappAppStorage.chats[index].totalUnreadedChat > 0){
////                currentWhatsappAppStorage.chats[index].totalUnreadedChat = 0
////            }else{
////                currentWhatsappAppStorage.chats[index].totalUnreadedChat = 1
////            }
////            
////            do{
////                try modelContext.save()
////            }catch{
////                print("Failed to update WhatsappAppStorage: \(error)")
////            }
////        }
//    }
    
//    @MainActor
//    func deleteAChat(for item: WhatsappChatsModel){
////        var currentWhatsappAppStorage: WhatsappAppStorage = updateStorage()
//        if let index = chatData.firstIndex(where: {$0.id == item.id}){
//            chatData.remove(at: index)
//            if let archivedDataIndex = archivedChatData.firstIndex(where: {$0.id == item.id}){
//                archivedChatData.remove(at: archivedDataIndex)
//            }
//        }
//        
////        if let index = currentWhatsappAppStorage.chats.firstIndex(where: {$0.id == item.id}){
////            currentWhatsappAppStorage.chats.remove(at: index)
////            if let archiveDataIndex = currentWhatsappAppStorage.archivedChats.firstIndex(where: {$0.id == item.id}){
////                currentWhatsappAppStorage.archivedChats.remove(at: archiveDataIndex)
////            }
////        }
////        
////        do{
////            try modelContext.save()
////        }catch{
////            print("Failed to update WhatsappAppStorage: \(error)")
////        }
//    }
    
//    private static func fetchOrCreateStorage(modelContext: ModelContext) -> WhatsappAppStorage {
//            do {
//                let fetchDescriptor = FetchDescriptor<WhatsappAppStorage>()
//                if let existing = try modelContext.fetch(fetchDescriptor).first {
//                    return existing
//                } else {
//                    let newStorage = WhatsappAppStorage()
//                    modelContext.insert(newStorage)
//                    try modelContext.save()
//                    return newStorage
//                }
//            } catch {
//                print("Failed to fetch or create WhatsappAppStorage: \(error)")
//                return WhatsappAppStorage()
//            }
//        }
    
//    @MainActor
//    private func updateStorage() -> WhatsappAppStorage{
//        do{
//            let fetchDescriptor = FetchDescriptor<WhatsappAppStorage>(sortBy: [SortDescriptor(\.id)])
//            let storage = try modelContext.fetch(fetchDescriptor).first ?? WhatsappAppStorage()
//            return storage
//        }catch{
//            print("Failed to update WhatsappAppStorage: \(error)")
//            return WhatsappAppStorage()
//        }
//    }
    
//    func fetchData(){
//        do{
//            let descriptor = FetchDescriptor<WhatsappChatsStorage>(sortBy: [SortDescriptor(\.id)])
//            let archivedDescriptor = FetchDescriptor<WhatsappArchivedChatsStorage>(sortBy: [SortDescriptor(\.id)])
//            
//            chatData = try modelContext.fetch(descriptor)
//            archivedChats = try modelContext.fetch(archivedDescriptor)
//        }catch{
//            print("Fetching data from view model failed: \(error)")
//        }
//    }
//}

enum WhatsappChatsStorageType {
    case regular(WhatsappChatsStorage)
    case archived(WhatsappArchivedChatsStorage)
}

@Observable class WhatsappChatsContextViewModel {
    var modelContext: ModelContext
    var chats = [WhatsappChatsStorage]()
    var archivedChats = [WhatsappArchivedChatsStorage]()
    var searchText: String = ""
    var isMoreSheetShowed: Bool = false
    var sheetData : WhatsappChatsStorageType? = nil {
        didSet{
            isMoreSheetShowed = true
        }
    }
    var isShowingArchivedChats: Bool = false
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
            // Add more contacts here...
        ],
        "A": [
            Contact(name: "Astral Projection", details: nil),
            // Add more contacts here...
        ],
        // Add more sections here...
    ]
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchData()
    }
    
    func addSample(){
        print("Adding sample")
        let chats = WhatsappChatsStorage(username: WhatsappChatsExample.Chat.username, latestActivityTime: WhatsappChatsExample.Chat.latestActivityTime, latestChatBubble: WhatsappChatsExample.Chat.latestChatBubble, pinned: WhatsappChatsExample.Chat.pinned, totalUnreadedChat: WhatsappChatsExample.Chat.totalUnreadedChat)
        
        modelContext.insert(chats)
        fetchData()
        print("Adding sample finished")
    }
    
    func deleteChat(for item: WhatsappChatsStorage){
        modelContext.delete(item)
        do{
            try modelContext.save()
            fetchData()
        }catch{
            print("Error when trying to update data in deleteChat(): \(error)")
        }
    }
    
    func deleteArchivedChat(for item: WhatsappArchivedChatsStorage){
        modelContext.delete(item)
        do{
            try modelContext.save()
            fetchData()
        }catch{
            print("Error when trying to update data in deleteArchivedChat(): \(error)")
        }
    }
    
    func togglePinned(for item: WhatsappChatsStorage){
        item.pinned.toggle()
        
        do{
            try modelContext.save()
            fetchData()
        }catch{
            print("Error when trying to update the data after togglePinned(): \(error)")
        }
    }
    
    func toggleRead(for item: WhatsappChatsStorage){
        if(item.totalUnreadedChat > 0){
            item.totalUnreadedChat = 1
        }else{
            item.totalUnreadedChat = 0
        }
        
        do{
            try modelContext.save()
            fetchData()
        }catch{
            print("Error when trying to update data in toggleRead(): \(error)")
        }
    }
    
    func moveToArchive(for item: WhatsappChatsStorage){
        let archivedChat = WhatsappArchivedChatsStorage(id: item.id, username: item.username, latestActivityTime: item.latestActivityTime, latestChatBubble: item.latestChatBubble, pinned: item.pinned, totalUnreadedChat: item.totalUnreadedChat)
        
        modelContext.insert(archivedChat)
        modelContext.delete(item)
        
        do{
            try modelContext.save()
            fetchData()
        }catch{
            print("Error when trying to update data in moveToArchive(): \(error)")
        }
    }
    
    func moveToChats(for item: WhatsappArchivedChatsStorage){
        let theChat = WhatsappChatsStorage(id: item.id, username: item.username, latestActivityTime: item.latestActivityTime, latestChatBubble: item.latestChatBubble, pinned: item.pinned, totalUnreadedChat: item.totalUnreadedChat)
        
        modelContext.insert(theChat)
        modelContext.delete(item)
        
        do{
            try modelContext.save()
            fetchData()
        }catch{
            print("Error when trying to update data in moveToChats(): \(error)")
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
    
    func fetchData(){
        do{
            let descriptor = FetchDescriptor<WhatsappChatsStorage>(sortBy: [SortDescriptor(\.id)])
            let archivedDescriptor = FetchDescriptor<WhatsappArchivedChatsStorage>(sortBy: [SortDescriptor(\.id)])
            
            chats = try modelContext.fetch(descriptor)
            archivedChats = try modelContext.fetch(archivedDescriptor)
        }catch{
            print("Fetching data from view model failed: \(error)")
        }
    }
    
    @MainActor
    func initiateData(){
        print("iniating data...")
        if(chats.isEmpty){
            WhatsappChatsExample.Chats.map{
                let chat = WhatsappChatsStorage(id: $0.id, username: $0.username, latestActivityTime: $0.latestActivityTime, latestChatBubble: $0.latestChatBubble, pinned: $0.pinned, totalUnreadedChat: $0.totalUnreadedChat)
                
                modelContext.insert(chat)
                do{
                    try modelContext.save()
                    fetchData()
                }catch{
                    print("Error while initializing data: \(error)")
                }
            }
        }
        print("initiate data finished")
    }
}
