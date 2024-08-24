//
//  WhatsappGroupSetupScreen.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 21/08/24.
//

import SwiftUI

struct WhatsappNewGroupSetupScreen: View {
    @Binding var viewModel: WhatsappChatPartnerPickerViewModel
    @State private var groupName = ""
    var body: some View {
        List{
            Section{
                channelSetupHeaderView()
            }
            
            Section {
                Text("Disappearing messages")
                Text("Group permissions")
            }
            
            Section(content: {
                WhatsappSelectedChatPartnerView(viewModel: $viewModel)
            }, header: {
                Text("Participants: \(viewModel.selectedChatPartners.count)/\(WhatsappChannelConstants.maxGroupParticipants)")
                    .bold()
            })
            .listRowBackground(Color.clear)
        }
        .navigationTitle("New group")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            createButton()
        }
    }
    
    private func channelSetupHeaderView() -> some View {
        HStack{
            profileImageView()
            
            TextField("", text: $groupName, prompt: Text("Group name (optional"), axis: .vertical)
        }
    }
    
    private func profileImageView() -> some View {
        Button(action: {
            print("ini profile image view tapped")
        }){
            ZStack{
                Circle()
                    .frame(width: 60, height: 60)
                Image(systemName: "camera")
                    .foregroundStyle(Color(.white))
            }
        }
    }
}

extension WhatsappNewGroupSetupScreen {
    @ToolbarContentBuilder
    private func createButton() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing){
            Button(action: {}){
                Text("Create")
                    .bold()
            }
            .disabled(viewModel.disabledNextButton)
        }
    }
}

#Preview {
    NavigationStack{
        WhatsappNewGroupSetupScreen(viewModel: .constant(WhatsappChatPartnerPickerViewModel()))
    }
}
