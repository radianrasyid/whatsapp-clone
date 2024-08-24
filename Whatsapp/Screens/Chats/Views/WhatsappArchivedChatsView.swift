//
//  WhatsappArchivedChatsView.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 07/08/24.
//

import Foundation
import SwiftUI

struct WhatsappArchivedChatsView: View {
    @Binding var viewModel: WhatsappChatsContextViewModel
    var body: some View {
        NavigationStack{
            List{
                HStack(alignment: .center){
                    Spacer()
                    Text("These chats stay archived when new messages are received. Tap to change")
                        .multilineTextAlignment(.center)
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray))
                    Spacer()
                }
                .listRowBackground(Color(.lightGray).opacity(0.3))
                
                if(viewModel.archivedChats.isEmpty){
                    HStack{
                        Spacer()
                        Text("No archived chats")
                            .font(.subheadline)
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                }
                
                ForEach($viewModel.archivedChats.sorted(by: {
                    (chat1, chat2) -> Bool in
                    if chat1.wrappedValue.pinned && !chat2.wrappedValue.pinned{
                        return true
                    }else if !chat1.wrappedValue.pinned && chat2.wrappedValue.pinned{
                        return false
                    }else{
                        return false
                    }
                }), id: \.id){
                    item in
                    WhatsappChatItemComp(data: WhatsappChatsStorage(id: item.wrappedValue.id, username: item.wrappedValue.username, latestActivityTime: item.wrappedValue.latestActivityTime, latestChatBubble: item.wrappedValue.latestChatBubble, pinned: item.wrappedValue.pinned, totalUnreadedChat: item.wrappedValue.totalUnreadedChat))
                        .whatsappLeadingSwipeActionsArchivedModifier(item: item.wrappedValue, viewModel: $viewModel)
                        .whatsappTrailingSwipeActionsArchivedModifier(item: item.wrappedValue, viewModel: $viewModel)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
//                ToolbarItem(placement: .topBarLeading){}
                ToolbarItem(placement: .principal){
                    Text("Archive")
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {}, label: {
                        Text("Edit")
                    })
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct WhatsappLeadingSwipeActionsArchivedModifier: ViewModifier {
    let item: WhatsappArchivedChatsStorage
    @Binding var viewModel: WhatsappChatsContextViewModel

    func body(content: Content) -> some View {
        content
            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                Button(action: {
                    viewModel.toggleRead(for: WhatsappChatsStorage(id: item.id, username: item.username, latestActivityTime: item.latestActivityTime, latestChatBubble: item.latestChatBubble, pinned: item.pinned, totalUnreadedChat: item.totalUnreadedChat))
                }, label: {
                    VStack {
                        Image(systemName: item.totalUnreadedChat > 0 ? "message.fill" : "message.badge.fill")
                        Text(item.totalUnreadedChat > 0 ? "Read" : "Unread")
                    }
                    .tint(Color(.systemGreen))
                    .foregroundStyle(Color(.red))
                })
            }
    }
}

struct WhatsappTrailingSwipeActionsArchivedModifier: ViewModifier {
    let item: WhatsappArchivedChatsStorage
    @Binding var viewModel: WhatsappChatsContextViewModel

    func body(content: Content) -> some View {
        content
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button(action: {
                    withAnimation(.easeOut(duration: 0.2)){
                        viewModel.moveToChats(for: WhatsappArchivedChatsStorage(id: item.id, username: item.username, latestActivityTime: item.latestActivityTime, latestChatBubble: item.latestChatBubble, pinned: item.pinned, totalUnreadedChat: item.totalUnreadedChat))
                    }
                }, label: {
                    VStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Unarchived")
                    }
                    .tint(Color(.systemGreen))
                    .foregroundStyle(Color(.red))
                })
                Button(action: {
                    viewModel.sheetData = .archived(item)               }, label: {
                    VStack {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(45))
                        Text("More")
                    }
                    .rotationEffect(.degrees(45))
                    .tint(Color(.systemGray6))
                    .foregroundStyle(Color(.red))
                })
            }
    }
}

extension View {
    func whatsappLeadingSwipeActionsArchivedModifier(item: WhatsappArchivedChatsStorage, viewModel: Binding<WhatsappChatsContextViewModel>) -> some View {
        self.modifier(WhatsappLeadingSwipeActionsArchivedModifier(item: item, viewModel: viewModel))
    }

    func whatsappTrailingSwipeActionsArchivedModifier(item: WhatsappArchivedChatsStorage, viewModel: Binding<WhatsappChatsContextViewModel>) -> some View {
        self.modifier(WhatsappTrailingSwipeActionsArchivedModifier(item: item, viewModel: viewModel))
    }
}
