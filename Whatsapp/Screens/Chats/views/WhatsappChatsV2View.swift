//
//  WhatsappChatsV2View.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 09/08/24.
//

import Foundation
import SwiftUI
import SwiftData

struct WhatsappChatsV2View: View {
    @State private var viewModel: WhatsappChatsContextViewModel
    var body: some View {
        List{
            ForEach(viewModel.chats, id: \.id){ item in
                Text(item.username)
            }
            
            Button(action:{
                viewModel.addSample()
            }, label: {
                Text("Add Chat")
            })
        }
    }
    
    init(modelContext: ModelContext){
        let viewModel = WhatsappChatsContextViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
}
