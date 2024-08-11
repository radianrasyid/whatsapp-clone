//
//  WhatsappChatItemComp.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 05/08/24.
//

import SwiftUI

struct WhatsappChatItemComp: View {
    var data: WhatsappChatsStorage
    var body: some View {
        HStack(alignment: .top){
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(.circle)
            
            VStack(alignment: .leading, spacing: 4){
                Text(data.username)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(data.latestChatBubble)
                    .lineLimit(1)
                    .font(.caption)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4){
                Text(data.latestActivityTime)
                    .font(.subheadline)
                    .foregroundStyle(Color(.secondaryLabel))
                HStack{
                    Image(systemName: "pin.fill")
                        .resizable()
                        .frame(width: data.pinned ? 13 : 0, height: data.pinned ? 16 : 0)
                        .rotationEffect(.degrees(45))
                    if(data.totalUnreadedChat > 0){
                        Text("\(data.totalUnreadedChat)")
                            .font(.caption)
                            .foregroundStyle(Color(.darkText))
                            .padding(.all, 5)
                            .background(Color(.accent))
                            .clipShape(.circle)
                    }
                }
                    
            }
        }
    }
}

#Preview {
    WhatsappChatItemComp(data: WhatsappChatsStorage(username: "John Doe", latestActivityTime: "Thursday", latestChatBubble: "Bjir", pinned: true, totalUnreadedChat: 0))
}
