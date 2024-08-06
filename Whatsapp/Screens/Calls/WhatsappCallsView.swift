//
//  WhatsappCallsView.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 05/07/24.
//

import Foundation
import SwiftUI

enum WhatsappCallsTab {
    case all
    case missed
}

struct WhatsappCallsView: View {
    
    @State private var viewModel = WhatsappCallsViewModel()
    
    var body: some View {
        NavigationStack{
            List{
                switch viewModel.selectedTab {
                case .all:
                    Section(content: {
                        WhatsappFavoriteCalls(username: "Radian Rasyid")
                    }, header: {
                        HStack{
                            Text("Favorites")
                            Spacer()
                            Button(action: {}, label: {
                                Text("More")
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 5)
                                    .font(.caption)
                                    .foregroundStyle(Color(.label))
                                    .background(Color(.systemGray6))
                                    .clipShape(.rect(cornerRadius: 10))
                            })
                        }
                        .listRowInsets(EdgeInsets())
                    })
                    
                    Section(content: {
                        WhatsappCallsList(numberKnown: true, contactName: "John Doe", phoneNumber: "085363542647", callStatus: .incoming, infoAction: {
                            viewModel.listId = String(2)
                        })
                    }, header: {
                        Text("Recent")
                            .listRowInsets(EdgeInsets())
                    })
                case .missed:
                    
                    Section(content: {
                        WhatsappCallsList(numberKnown: true, contactName: "John Doe", phoneNumber: "085363542647", callStatus: .missed, infoAction: {
                            viewModel.listId = String(3)
                        })
                    }, header: {
                        Text("Recent")
                            .listRowInsets(EdgeInsets())
                    })
                }
            }
            .listStyle(DefaultListStyle())
            .searchable(text: $viewModel.searchValue)
            .navigationTitle("Calls")
            .searchPresentationToolbarBehavior(.avoidHidingContent)
            .navigationDestination(isPresented: $viewModel.showDetail){
                WhatsappCallsDetailView(isShowingDetail: $viewModel.showDetail)
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Menu(content: {
                        Button(action: {}, label: {
                            HStack{
                                Text("Edit")
                                Spacer()
                                Image(systemName: "pencil.line")
                            }
                        })
                    }, label: {
                        Button(action: {}, label: {
                            Image(systemName: "ellipsis")
                        })
                        .foregroundStyle(Color(.label))
                    })
                }
                
                ToolbarItem(placement: .principal){
                    HStack(spacing: 0) {
                        WhatsappTabButton(title: "All", isSelected: viewModel.selectedTab == .all, action: {
                            withAnimation(.spring(duration: 0.2)){
                                viewModel.selectedTab = .all
                            }
                        })
                        WhatsappTabButton(title: "Missed", isSelected: viewModel.selectedTab == .missed, action: {
                            withAnimation(.spring(duration: 0.2)){
                                viewModel.selectedTab = .missed
                            }
                        })
                            }
                    .frame(height: 35)
                            .background(Color(UIColor.systemGray5))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        viewModel.createLinkSheet.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .foregroundStyle(Color(.label))
                }
            }
            .sheet(isPresented: $viewModel.createLinkSheet, onDismiss: {
                print("Create link process dismissed")
            }){
                WhatsappCallsCreateLink(createLinkSheet: $viewModel.createLinkSheet, callType: $viewModel.callType)
            }
        }
    }
}

struct WhatsappTabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) {
                    Text(title)
                .font(.caption)
                .fontWeight(.medium)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(isSelected ? Color(UIColor.systemBackground) : Color.clear)
                        .cornerRadius(6)
                }
        .foregroundColor(isSelected ? .primary : .secondary)
    }
}

#Preview {
    WhatsappCallsView()
}
