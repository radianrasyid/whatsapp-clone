//
//  WhatsappUpdatesView.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 05/07/24.
//

import Foundation
import SwiftUI

struct WhatsappUpdatesView: View {
    
    @State private var viewModel = WhatsappUpdatesViewModel()
    
    var body: some View {
        NavigationStack{
            List{
                Section(content: {
                    WhatsappStoriesStatusTitle(username: "Radian Rasyid")
                }, header: {
                    Text("Status")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .textCase(.none)
                })
                
                Section("Recent updates"){
                    ForEach(viewModel.friendsUpdates, id: \.id){
                        item in
                        if(!item.viewed){
                            WhatsappContactList(contactName: item.name, updatedAt: item.updatedAt, image: item.image)
                                .onTapGesture{
                                    withAnimation(.interactiveSpring(duration: 0.3)){
                                        viewModel.toggleViewed(for: item)
                                    }
                                }
                        }
                    }
                }
                
                // MARK: -VIEW UPDATES COMPONENT HERE
                viewModel.isUpdatesEmpty
                
                Section(content: {
                    Text("Stay updated on topics that matter to you. Find channels to follow below.")
                        .font(.subheadline)
                        .listRowBackground(Color(.systemBackground))
                        .listRowSeparatorTint(Color(.systemBackground))
                    
                    Section(content: {
                        if(viewModel.findChannelsToFollowExpanded){
                            ForEach(0..<5){
                                item in
                                WhatsappUnfollowedChannelList(channelName: "Radian Rasyid", followerCount: 10)
                            }
                        }
                    }, header: {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)){
                                viewModel.findChannelsToFollowExpanded.toggle()
                            }
                        }, label: {
                            HStack{
                                Text("Find channels to follow")
                                Spacer()
                                Image(systemName:  "chevron.down")
                                    .rotationEffect(.degrees(viewModel.findChannelsToFollowExpanded ? 0 : 180))
                                    .animation(.easeInOut(duration: 0.3), value: viewModel.findChannelsToFollowExpanded)
                            }
                            .font(.caption)
                            .foregroundStyle(.white)
                        })
                        .listRowSeparatorTint(Color(.systemBackground))
                    })
                    .listRowBackground(Color(.systemBackground))
                    
                    Button(action: {
                        viewModel.navigateToFindChannels.toggle()
                    }, label: {
                        Text("Explore more")
                            .fontWeight(.semibold)
                            .frame(width: 150, height: 35)
                            .background(Color(.systemGreen))
                            .foregroundStyle(Color(.systemBackground))
                            .clipShape(.rect(cornerRadius: 20))
                    })
                    .listRowBackground(Color(.systemBackground))
                }, header: {
                    Text("Channels")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .textCase(.none)
                })
                
            }
            .searchable(text: $viewModel.searchableString)
            .navigationTitle("Updates")
            .navigationDestination(isPresented: $viewModel.navigateToFindChannels){
                WhatsappFindChannels(navigateToFindChannels: $viewModel.navigateToFindChannels)
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Menu {
                        Button{
                            print("status privacy clicked")
                        }label: {
                            HStack{
                                Text("Status privacy")
                                Spacer()
                                Image(systemName: "lock.fill")
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(Color(.label))
                    }
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
    }
}

struct MyDisclosureStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Button {
                configuration.isExpanded.toggle()
            } label: {
                HStack(alignment: .firstTextBaseline) {
                    configuration.label
                    Spacer()
                    Text(configuration.isExpanded ? "hide" : "show")
                        .foregroundColor(.accentColor)
                        .font(.caption.lowercaseSmallCaps())
                        .animation(nil, value: configuration.isExpanded)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            if configuration.isExpanded {
                List{
                    configuration.content
                }
            }
        }
    }
}


#Preview {
    WhatsappUpdatesView()
}
