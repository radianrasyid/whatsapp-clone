//
//  WhatsappChatPartnerPickerView.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 20/08/24.
//

import SwiftUI

struct WhatsappChatPartnerPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchableText = ""
    @State private var viewModel = WhatsappChatPartnerPickerViewModel()
    var onCreate: (_ newChannel: WhatsappChannelItem) -> Void
    
    var body: some View {
        NavigationStack(path: $viewModel.navStack){
            List{
                ForEach(WhatsappChatPartnerPickerOption.allCases){
                    item in
                    HeaderItemView(onTap: {
                        viewModel.handleNavigation(item)
                    }, item: item)
                }
                
                Section(content: {
                    ForEach(viewModel.users, id: \.uuid){
                        item in
                        Button(action: {
                            onCreate(.placeholder)
                        }){
                            WhatsappChatPartnerRowView(user: item)
                        }
                    }
                }, header: {
                    Text("Contacts on Whatsapp")
                        .fontWeight(.bold)
                })
                
                if viewModel.isPaginatable{
                    loadMoreUsers()
                }
            }
            .navigationTitle("New Chat")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: WhatsappChannelCreationRoute.self, destination: {
                route in
                destinationView(for: route)
            })
            .searchable(text: $searchableText, prompt: "Search name or number")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundStyle(Color(.label))
                    })
                }
            }
            .alert(isPresented: $viewModel.errorState.showError){
                Alert(
                    title: Text(viewModel.errorState.errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func loadMoreUsers () -> some View {
        ProgressView()
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear)
            .task {
                await viewModel.fetchUsers()
            }
    }
}

extension WhatsappChatPartnerPickerView {
    @ViewBuilder
    private func destinationView(for route: WhatsappChannelCreationRoute) -> some View {
        switch route{
        case .addGroupChatMembers:
            WhatsappAddGroupChatMemberView(viewModel: $viewModel)
        case .setUpGroupChat:
            WhatsappNewGroupSetupScreen(viewModel: $viewModel)
        }
    }
}

extension WhatsappChatPartnerPickerView{
    private struct HeaderItemView: View {
        var onTap: () -> Void
        let item: WhatsappChatPartnerPickerOption
        var body: some View{
            Button(action: onTap, label: {
                buttonBody()
            })
        }
        
        private func buttonBody() -> some View {
            HStack{
                Image(systemName: item.imageName)
                    .font(.footnote)
                    .frame(width: 40, height: 40)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
                    .foregroundStyle(Color(.label))
                Text(item.title)
                    .foregroundStyle(Color(.label))
            }
        }
    }
}

enum WhatsappChatPartnerPickerOption: String, CaseIterable, Identifiable{
    case newGroup = "New Group"
    case newContact = "New Contact"
    case newCommunity = "New Community"
    
    var id: String {
        return rawValue
    }
    
    var title: String {
        return rawValue
    }
    
    var imageName: String {
        switch self {
        case .newGroup:
            return "person.2.fill"
        case .newContact:
            return "person.fill.badge.plus"
        case .newCommunity:
            return "person.3.fill"
        }
    }
}

#Preview {
    WhatsappChatPartnerPickerView{
        channel in
        
    }
}
