//
//  WhatsappContactList.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 06/07/24.
//

import Foundation
import SwiftUI

struct WhatsappContactList: View {
    
    var contactName: String
    var updatedAt: String
    var image: String
    
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
                Text(updatedAt)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}
