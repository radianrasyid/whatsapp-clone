//
//  WhatsappChatList.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 06/07/24.
//

import Foundation
import SwiftUI

struct WhatsappChatList: View {
    
    var contactName: String
    var messageContent: String
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
            VStack(alignment: .leading) {
                Text(contactName)
                    .font(.body)
                    .fontWeight(.semibold)
                Text(messageContent)
                    .lineLimit(2)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}
