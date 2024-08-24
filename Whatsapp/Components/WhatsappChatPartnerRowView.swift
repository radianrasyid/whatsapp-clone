//
//  WhatsappChatPartnerRowView.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 20/08/24.
//

import SwiftUI

struct WhatsappChatPartnerRowView<Content: View>: View {
    private let user: WhatsappUserItem
    private let trailingItems: Content
    
    init(user: WhatsappUserItem, @ViewBuilder trailingItems: () -> Content = { EmptyView() }) {
        self.user = user
        self.trailingItems = trailingItems()
    }
    
    var body: some View {
        HStack{
            Circle()
                .frame(width: 40, height: 40)
                .foregroundStyle(Color(.label))
            
            VStack(alignment: .leading){
                Text(user.username)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.label))
                
                Text(user.bio ?? "")
                    .font(.footnote)
                    .foregroundStyle(Color(.systemGray))
            }
            
            trailingItems
        }
    }
}

#Preview {
    WhatsappChatPartnerRowView(user: WhatsappUserItem(uuid: "1", username: "Radian Rasyid", email: "radian.rasyid9@gmail.com", bio: "Hey there, I'm using Whatsapp"))
}
