//
//  WhatsappRoomChatView.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 11/08/24.
//

import SwiftUI

struct WhatsappRoomChatView: View {
    var data: WhatsappChatsStorage
    @State private var isTextfieldFocused: Bool = false
    var body: some View {
        NavigationStack{
            WhatsappMessageListView()
            .simultaneousGesture(DragGesture().onChanged{
                _ in
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            })
            .toolbar{
                leadingNavItems()
                trailingNavItems()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
            .safeAreaInset(edge: .bottom, spacing: 0){
                WhatsappChatsInputGroup()
                    .background(Color(.whatsappWhite))
            }
        }
    }
}

extension WhatsappRoomChatView {
    @ToolbarContentBuilder
    private func leadingNavItems() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading){
            Button(action: {}, label: {
                HStack{
                    Image(systemName: "person.circle.fill")
                    Text("Radian Rasyid")
                        .font(.subheadline)
                }
                .foregroundStyle(Color(.label))
            })
        }
    }
    
    @ToolbarContentBuilder
    private func trailingNavItems() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing){
            Button(action: {}, label: {
                Image(systemName: "video")
                    .foregroundStyle(Color(.label))
            })
            Button(action: {}, label: {
                Image(systemName: "phone")
                    .foregroundStyle(Color(.label))
            })
        }
    }
}

#Preview{
    WhatsappRoomChatView(data: WhatsappChatsStorage(id: UUID(), username: "Radian Rasyid", latestActivityTime: "11:33 AM", latestChatBubble: "damn bro", pinned: true, totalUnreadedChat: 3))
}
