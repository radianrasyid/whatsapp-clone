//
//  WhatsappAddGroupChatMemberView.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 21/08/24.
//

import SwiftUI

struct WhatsappAddGroupChatMemberView: View {
    @Binding var viewModel: WhatsappChatPartnerPickerViewModel
    @State private var searchableString = ""
    var body: some View {
        List{
            
            if viewModel.showSelectedUsers {
                WhatsappSelectedChatPartnerView(viewModel: $viewModel)
            }
            
            Section(content: {
                ForEach(viewModel.users, id: \.uuid){
                    item in
                    Button(action: {
                        viewModel.handleItemSelection(item)
                    }, label: {
                        chatPartnerRowView(item)
                    })
                }
            }, header: {
                Text("Testing")
            })
            
            if viewModel.isPaginatable{
                loadMoreUsers()
            }
        }
        .toolbar{
            titleView()
            nextView()
        }
        .animation(.easeInOut, value: viewModel.showSelectedUsers)
        .searchable(text: $searchableString,placement: .navigationBarDrawer(displayMode: .always) ,prompt: "Search name or number")
    }
    
    private func loadMoreUsers () -> some View {
        ProgressView()
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear)
            .task {
                await viewModel.fetchUsers()
            }
    }
    
    private func chatPartnerRowView(_ user: WhatsappUserItem) -> some View {
        WhatsappChatPartnerRowView(user: user){
            Spacer()
            
            let isSelected = viewModel.isUserSelected(user)
            let imageName = isSelected ? "checkmark.circle.fill" : "circle"
            let selectedColor = isSelected ? Color(.systemBlue) : Color(.systemGray4)
            Image(systemName: imageName)
                .foregroundStyle(selectedColor)
                .imageScale(.large)
        }
    }
}

extension WhatsappAddGroupChatMemberView {
    @ToolbarContentBuilder
    private func titleView() -> some ToolbarContent {
        ToolbarItem(placement: .principal){
            VStack{
                Text("Add participants")
                    .bold()
                
                let count = viewModel.selectedChatPartners.count
                let amount = WhatsappChannelConstants.maxGroupParticipants
                Text("\(count)/\(amount)")
                    .foregroundStyle(.gray)
                    .font(.footnote)
                
            }
        }
    }
    
    @ToolbarContentBuilder
    private func nextView() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing){
            Button(action: {
                viewModel.navStack.append(.setUpGroupChat)
            }){
                Text("Next")
                    .bold()
            }
            .disabled(viewModel.disabledNextButton)
        }
    }
}

#Preview {
    NavigationStack{
        WhatsappAddGroupChatMemberView(viewModel: .constant(WhatsappChatPartnerPickerViewModel()))
    }
}
