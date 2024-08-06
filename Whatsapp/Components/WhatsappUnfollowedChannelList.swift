//
//  WhatsappUnfollowedChannelList.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 06/07/24.
//

import Foundation
import SwiftUI

struct WhatsappUnfollowedChannelList: View {
    
    var channelName: String
    var followerCount: CGFloat
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
            VStack(alignment: .leading) {
                Text(channelName)
                    .font(.body)
                    .fontWeight(.semibold)
                Text("\(followerCount)M followers")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Button{
                print("[log]: a user followed f1 in channel")
            }label: {
                Text("Follow")
                    .foregroundStyle(Color(.white))
                    .frame(width: 80, height: 30)
                    .background(Color(.systemGreen))
                    .clipShape(.rect(cornerRadius: 10))
            }
        }
    }
}
