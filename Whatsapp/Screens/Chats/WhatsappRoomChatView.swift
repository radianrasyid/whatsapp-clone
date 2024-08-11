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
            ScrollView{
                LazyVStack{
                    ForEach(0..<10, id: \.self){
                        item in
                        Text("\(data.username)")
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .background(Color(.gray).opacity(0.1))
                    }
                }
            }
            .simultaneousGesture(DragGesture().onChanged{
                _ in
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            })
            .toolbar{
                leadingNavItems()
                trailingNavItems()
            }
            .safeAreaInset(edge: .bottom){
                WhatsappChatsInputGroup()
                    .background(Color(.whatsappWhite))
            }
            .toolbar(.hidden, for: .tabBar)
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
