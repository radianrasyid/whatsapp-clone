//
//  WhatsappStoriesStatusTitle.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 06/07/24.
//

import Foundation
import SwiftUI

struct WhatsappStoriesStatusTitle: View {
    var username: String
    var body: some View {
        HStack{
            Text(username)
                .font(.headline)
            
            Spacer()
            
            HStack(spacing: 5) {
                Button {
                    // Action
                } label: {
                    Image(systemName: "camera.fill")
                }
                .background(Color(.systemGray5))
                .foregroundStyle(Color(.label))
                .clipShape(Circle())
                
                Button {
                    // Action
                } label: {
                    Image(systemName: "pencil")
                }
                .background(Color(.systemGray5))
                .foregroundStyle(Color(.label))
                .clipShape(Circle())
            }
        }
    }
}

struct WhatsappFavoriteCalls: View {
    let username: String
    var body: some View {
        HStack{
            Text(username)
                .font(.headline)
            
            Spacer()
            
            HStack(spacing: 5){
                Button(action: {}, label: {
                    Image(systemName: "phone")
                })
                
                Button(action: {}, label: {
                    Image(systemName: "video")
                })
            }
            .foregroundStyle(Color(.label))
        }
    }
}
