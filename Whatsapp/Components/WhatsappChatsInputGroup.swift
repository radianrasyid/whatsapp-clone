//
//  WhatsappChatsInputGroup.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 11/08/24.
//

import SwiftUI

struct WhatsappChatsInputGroup: View {
    @State private var textfieldValue = ""
    @FocusState var isFocused: Bool
    var body: some View {
        HStack(alignment: .center, spacing: 12){
            Button(action: {}, label: {
                Image(systemName: "plus")
                    .foregroundStyle(Color(.label))
            })
            
            HStack(alignment: .center){
                TextField("", text: $textfieldValue, axis: .vertical)
                    .focused($isFocused)
                Button(action: {}, label: {
                    Image(systemName: "document")
                        .foregroundStyle(Color(.label))
                })
            }
            .padding(6)
            .background(Color(.systemGray))
            .clipShape(.rect(cornerRadius: 20))
            
            Button(action: {}, label: {
                Image(systemName: "camera")
                    .foregroundStyle(Color(.label))
            })
            Button(action: {}, label: {
                Image(systemName: "phone")
                    .foregroundStyle(Color(.label))
            })
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 10)
        .background(Color(.whatsappWhite))
    }
}

#Preview {
    WhatsappChatsInputGroup()
}
