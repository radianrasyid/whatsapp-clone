//
//  WhatsappChatPartnerPickerViewModel.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 21/08/24.
//

import Foundation
import SwiftUI
import FirebaseAuth

enum WhatsappChannelCreationRoute {
    case addGroupChatMembers
    case setUpGroupChat
}

enum WhatsappChannelConstants {
    static let maxGroupParticipants = 12
}

@Observable
class WhatsappChatPartnerPickerViewModel {
    var navStack = [WhatsappChannelCreationRoute]()
    var selectedChatPartners = [WhatsappUserItem]()
    private(set) var users: [WhatsappUserItem] = []
    var errorState: (showError: Bool, errorMessage: String) = (false, "Uh oh!")
    private var lastCursor: String?
    
    //MARK: COMPUTED PROPERTIES
    var showSelectedUsers: Bool {
        return !selectedChatPartners.isEmpty
    }
    
    var disabledNextButton: Bool {
        return selectedChatPartners.isEmpty
    }
    
    var isPaginatable: Bool {
        return !users.isEmpty
    }
    
    init(){
        Task{
            await fetchUsers()
        }
    }
    
    func fetchUsers() async {
        do{
            let userNode = try await WhatsappUserService.paginateUsers(lastCursor: lastCursor, pageSize: 5)
            var fetchedUsers = userNode.users
            guard let currentUuid = Auth.auth().currentUser?.uid else {return}
            fetchedUsers = fetchedUsers.filter{$0.uuid != currentUuid}
            self.users.append(contentsOf: fetchedUsers)
            self.lastCursor = userNode.currentCursor
            print("this is last cursor: \(lastCursor ?? "") \(users.count)")
        }catch{
            print("👨🏻‍💻 -> failed to fetch users in WhatsappChatPartnerPickerViewModel")
        }
    }
    
    func handleNavigation(_ item: WhatsappChatPartnerPickerOption) -> Void {
        switch item {
        case .newGroup:
            navStack.append(.addGroupChatMembers)
        case .newContact:
            navStack.append(.addGroupChatMembers)
        case .newCommunity:
            navStack.append(.addGroupChatMembers)
        }
    }
    
    func handleItemSelection(_ item: WhatsappUserItem){
        if(navStack.contains(where: {$0.self == .setUpGroupChat})){
            if(selectedChatPartners.count > 1){
                if(isUserSelected(item)){
                    //deselect
                    guard let index = selectedChatPartners.firstIndex(where: {$0.uuid == item.uuid}) else {return}
                    selectedChatPartners.remove(at: index)
                }else{
                    //select
                    selectedChatPartners.append(item)
                }
            }else{
                errorState.errorMessage = "A group is usually 3 people or more, you already erase until one person left, you kidding me?"
                errorState.showError = true
            }
        }
        else{
            if(isUserSelected(item)){
                //deselect
                guard let index = selectedChatPartners.firstIndex(where: {$0.uuid == item.uuid}) else {return}
                selectedChatPartners.remove(at: index)
            }else{
                //select
                selectedChatPartners.append(item)
            }
        }
    }
    
    func isUserSelected(_ item: WhatsappUserItem) -> Bool {
        let isSelected = selectedChatPartners.contains{$0.uuid == item.uuid}
        return isSelected
    }
}
